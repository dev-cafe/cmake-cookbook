#pragma once

template <typename T, typename Parameter, template <typename> class... Policies>
class NamedType : public Policies<NamedType<T, Parameter, Policies...>>... {
public:
  explicit NamedType(T const & value) : value_(value) {}
  explicit NamedType(T && value) : value_(value) {}
  T & get() { return value_; }
  T const & get() const { return value_; }

private:
  T value_;
};

template <typename T, typename Parameter, template <typename> class... Policies>
std::ostream & operator<<(std::ostream & os,
                          NamedType<T, Parameter, Policies...> const & object) {
  object.print(os);
  return os;
}
