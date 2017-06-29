# RetoIsban

Se ha realizado una pequeña aplicación que presenta el feed RSS de la sección de ciencia de El País. Para la realización de la misma se ha usado una arquitectura MVP, que facilita la modificación y comprensión del código, así como su testeabilidad.

La aplicación está escrita completamente en Swift ya que ha acelerado el desarrollo de la prueba técnica en sobremedida. Además de los requerimientos nombrados en el readme del reto, se ha añadido una forma de cacheo muy primitiva, pero fácimente aplicable a cualquier objeto.

## Técnologías usadas

* [Cocoapods](https://cocoapods.org/) para la gestión de librerías de terceros.
 * [FeedKit](http://codemirror.net/) para facilitar y asegurar el mejor parseo de feeds RSS. Se ha contemplado la posibilidad de hacer esto manualmente, pero el exhaustivo testeo al que está sometida FeedKit me ha convencido a la hora de usarla.
 * [KingFisher](https://github.com/onevcat/Kingfisher) para una gestión del cacheo de imágenes más eficiente.

### Hacerlo funcionar

Como en cualquier proyecto que se use Cocoapods, se deberá abrir siempre el .xcworkspace a la hora de compilar el código, para que Xcode reconozca las librerías externas.
