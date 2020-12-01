import Showdown from "showdown";
import HEAD from "next/head";

function M2H(resp) {
  var converter = new Showdown.Converter({ metadata: true });
  converter.setFlavor("github");
  var text = resp;
  var html = converter.makeHtml(text);

  return html;
}

export default function Arpp({ res }) {
  var html = M2H(res);

  return (
    <>
      <HEAD>
        <link
          rel="stylesheet"
          href="https://raw.githubusercontent.com/markdowncss/splendor/master/css/splendor.css"
        />
      </HEAD>
      <div dangerouslySetInnerHTML={{ __html: html }} />
    </>
  );
}

Arpp.getInitialProps = async (ctx) => {
  const res = await fetch(
    "https://raw.githubusercontent.com/jaykumarM5/Adrishta-Hackathon-Template/master/README.md"
  ).then((x) => x.text());
  // const todos = await res.json();

  return { res };
};
