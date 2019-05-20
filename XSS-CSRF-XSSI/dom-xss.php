<script>
var pos=document.URL.indexOf("name=")+5;
document.write('Hello, '+decodeURI(document.URL.substring(pos,document.URL.length)));
</script>
