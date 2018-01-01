#pragma once

#include <cstdio>
#include <cstdlib>
#include <map>
#include <sstream>
#include <string>
#include <type_traits>

/// Macro to be used to signal error conditions
#define ERROR(message)                                                              \
  {                                                                                 \
    std::ostringstream _err;                                                        \
    _err << "Fatal error.\n"                                                        \
         << " In function " << __func__ << " at line " << __LINE__ << " of file "   \
         << __FILE__ << "\n"                                                        \
         << message << std::endl;                                                   \
    std::fprintf(stderr, "%s\n", _err.str().c_str());                               \
    std::exit(EXIT_FAILURE);                                                        \
  }

namespace detail {
/*! \file Factory.hpp
 *  \class BaseFactory
 *  \brief A base class for the Factory Method
 *  \author Roberto Di Remigio
 *  \date 2017
 *  \tparam CreateObject type of the object creation callback function
 *
 *  This class provides basic functionality to implement the Factory Method
 *  as described by Alexandrescu in \cite Alexandrescu2001
 */
template <typename CreateObject> class BaseFactory {
private:
  /*! std::map from the object type identifier (a string) to its callback function */
  typedef std::map<std::string, CreateObject> CallbackMap;
  /*! std::pair of an object type identifier and a callback function */
  typedef typename CallbackMap::value_type CallbackPair;
  /*! const iterator */
  typedef typename CallbackMap::const_iterator CallbackConstIter;

protected:
  CallbackMap callbacks_;
  /*! \brief Retrieve constant iterator from map given object identifier
   * \param[in] objID  the object's identification string
   */
  CallbackConstIter retrieve(const std::string &objID) const {
    if (objID.empty())
      ERROR("No object identification string provided to the Factory.");
    CallbackConstIter i = callbacks_.find(objID);
    if (i == callbacks_.end())
      ERROR("The unknown object ID " + objID + " occurred in the Factory.");
    return i;
  }

private:
  /*! \brief Returns true on successful registration of the objID
   * \param[in] objID  the object's identification string
   * \param[in] functor the creation function related to the object type given
   */
  bool registerObject(const std::string &objID, const CreateObject &functor) {
    return callbacks_.insert(CallbackPair(objID, functor)).second;
  }
  /*! \brief Returns true if objID was already registered
   *  \param objID the object's identification string
   */
  bool unRegisterObject(const std::string &objID) {
    return callbacks_.erase(objID) == 1;
  }

public:
  /*! \brief Subscribes object with objID to factory
   * \param[in] objID  the object's identification string
   * \param[in] functor the creation function related to the object type given
   */
  void subscribe(const std::string &objID, const CreateObject &functor) {
    bool done = this->registerObject(objID, functor);
    if (!done)
      ERROR("Subscription of object ID " + objID + " to factory failed!");
  }
  /*! \brief Unsubscribes object with objID from factory
   *  \param objID the object's identification string
   */
  void unsubscribe(const std::string &objID) {
    bool done = this->unRegisterObject(objID);
    if (!done)
      ERROR("Unsubscription of object ID " + objID + " from factory failed!");
  }
};
} // namespace detail

/*! \file Factory.hpp
 *  \class Factory
 *  \brief C++11 implementation of the Factory Method
 *  \author Roberto Di Remigio
 *  \date 2017
 *  \tparam CreateObject type of the object creation callback function
 *
 *  Factory Method using a variadic template parameter pack to handle possible
 *  input value to the object creation callback function.
 */
template <typename CreateObject>
class Factory final : public detail::BaseFactory<CreateObject> {
public:
  /*! \brief Calls the appropriate creation functor, based on the passed objID
   *  \param[in] objID the object's identification string
   *  \param[in] data  input data for the creation of the object
   *  \tparam ObjectInputArgs type(s) of the object creation callback function input
   * arguments
   *  \note Return type is deduced based on the type(s) of the input
   *  argument(s) template parameter pack and the type of the object creation
   *  callback function.
   */
  template <typename... ObjectInputArgs>
  typename std::result_of<CreateObject(ObjectInputArgs...)>::type create(
      const std::string &objID,
      ObjectInputArgs... data) const {
    return (this->retrieve(objID)->second)(data...);
  }
};
