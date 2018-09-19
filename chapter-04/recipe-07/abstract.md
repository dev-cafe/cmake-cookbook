Some unit tests might take longer or get stuck (for instance, due to a high
file I/O load), and we may need to implement timeouts to terminate tests that
go overtime, before they pile up and delay the entire test and deploy pipeline.
In this recipe, we demonstrate one way of implementing timeouts, which can be
adjusted separately for each test.
