<div id="header">
    <a href="../" target="_blank"><img id="pict" src="images/wsd_logo.jpg" width="368" height="148"/></a>
    <ul id="nav">
        <?php
        $select =  $_GET['toLoad'];
            if($select == "works"){
                echo "<li class=\"current_page_item\"><a href=\"\">Works</a></li>";
            }else{
                echo "<li><a href=\"works.htm\" target=\"_self\">Works</a></li>";
            }
            //
            if($select == "news"){
                echo "<li class=\"current_page_item\"><a href=\"\">News</a></li>";
            }else{
                echo "<li><a href=\"news.htm\" target=\"_self\">News</a></li>";
            }
            //
            if($select == "products"){
                echo "<li class=\"current_page_item\"><a href=\"\">Products</a></li>";
            }else{
                echo "<li><a href=\"products.htm\" target=\"_self\">Products</a></li>";
            }
            //
            if($select == "about"){
                echo "<li class=\"current_page_item\"><a href=\"\">About</a></li>";
            }else{
                echo "<li><a href=\"about.htm\" target=\"_self\">About</a></li>";
            }
            //
            if($select == "contact"){
                echo "<li class=\"current_page_item\"><a href=\"\">Contact</a></li>";
            }else{
                echo "<li><a href=\"contact.htm\" target=\"_self\">Contact</a></li>";
            }
            //
            if($select == "liens"){
                echo "<li class=\"current_page_item\"><a href=\"\">Liens</a></li>";
            }else{
                echo "<li><a href=\"liens.htm\" target=\"_self\">Liens</a></li>";
            }
            //
            if($select == "backdrop"){
                echo "<li class=\"current_page_item\"><a href=\"\">Backdrop</a></li>";
            }else{
                echo "<li><a href=\"backdrop.htm\" target=\"_self\">Backdrop</a></li>";
            }
        ?>
    </ul>
    <? echo "<div id=\"logOutButtonHeader\">";
		echo "<textStandardHeader>";
			echo "<img id=\"logOutPict2\" src=\"images/delW.png\" width=\"10\" height=\"10\" border=\"none\"/><a href=\"logout.php\"> LOGOUT</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			echo "<img id=\"logOutPict3\" src=\"images/delW.png\" width=\"10\" height=\"10\" border=\"none\"/><a href=\"http://www.workshopdesign-home.com/php/getXML.php\" target=\"_blank\"> XML</a>";
		echo "</textStandardHeader>";
	echo "</div>"; ?>
</div>
