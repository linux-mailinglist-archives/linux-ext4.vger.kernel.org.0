Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38785280C36
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 04:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbgJBCFx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 22:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733275AbgJBCFx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 22:05:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E0C0613D0
        for <linux-ext4@vger.kernel.org>; Thu,  1 Oct 2020 19:05:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 197so443728pge.8
        for <linux-ext4@vger.kernel.org>; Thu, 01 Oct 2020 19:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WpAzpuEp/47QgIN5wpAExgluzWsxoLRfNzmwSIdbEL4=;
        b=gqGSyrVZ6PmxQPjWeyOfw1/51tZQueqL49ae0WjYw2PTqh8ZZw/TZO5aQwp+BavW6+
         7+Hk7O1fEvMcGOA4Nr9paSZZ7NILvChTEKPOVKl8nRqoEuC/QqwEOmurNB8oI23Cvi7y
         H/N59hfAZPXHz7kjPSt8zPHLZNN/lSK18MlbxLZv+oJTT2mBV1Kwc+7wv43wQhKVrQ90
         ATxVSxnqpwsWZ4K+ewlKhmflTc33Z1ycM+7hhBQ9D9r4UKlCW370+evlQTmj0e/IA4iV
         XdwShL5ta5P/xj9c4msoziy9d95hOhEBG3YxbjBvgTqKAMFQjGPQmqrnNDL4WtqCEJvo
         SnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WpAzpuEp/47QgIN5wpAExgluzWsxoLRfNzmwSIdbEL4=;
        b=bPUVOfc161hEUWkY4ktBz/o3Hg4foIjoC7CFuVeViIM/IALLgcfMp04z1dDX7uFF1e
         ASoXAJOJq2oaM2kbQmdGhdp/lYzFvUuoSsMpAMfcla29UFOR0HiUrxz8+7r6NQubr9iK
         zdaXEGmswZ+w0b5fMZGy2SJVF2qJMoG/5yfvNtY1fKbFrDOWaOxljPKS+QZif3rRRaK9
         0gJO2ByAZwAd5XdTR93NRdDD4iJS5JnbDCnSHBmxC0qkCW8EU8wgWu51arHGmyhfHxVK
         eexsHcJcydZ96lTIopkLiRJlx477JbM60bIgLkscXBQ1NbnS/0IVra2WX3cMXT0xfEhq
         TJmQ==
X-Gm-Message-State: AOAM5307T9gHB7+4f/3TsNOKKyGpElCfj8wGHTrFK2oc8EpQN4yAeprB
        yEVbztDOf0qyIPY8Om0A7W4f+1gB64EVkLbi
X-Google-Smtp-Source: ABdhPJzsVxDCjUCmb+0AMsn95Dc1G+mUK19j695E51gUSasKjvjaCwX7UK1nEKykAogO0HrtHm3k1w==
X-Received: by 2002:aa7:8e43:0:b029:151:3e50:afa6 with SMTP id d3-20020aa78e430000b02901513e50afa6mr5657134pfr.59.1601604351070;
        Thu, 01 Oct 2020 19:05:51 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a71sm7767537pfa.26.2020.10.01.19.05.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 19:05:50 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7C748802-8CC0-4881-90B3-DF362CACD902@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D7AA63F2-4001-454A-B1C4-535974D3B6FD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tests: replace perl usage with shell built-in
Date:   Thu, 1 Oct 2020 20:05:45 -0600
In-Reply-To: <20201001170817.GL23474@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Theodore Y. Ts'o" <tytso@MIT.EDU>
References: <20200719110033.78844-1-adilger@dilger.ca>
 <20201001145809.GA584291@mit.edu> <20201001170817.GL23474@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D7AA63F2-4001-454A-B1C4-535974D3B6FD
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 1, 2020, at 11:08 AM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
> 
> On Thu, Oct 01, 2020 at 10:58:09AM -0400, Theodore Y. Ts'o wrote:
>> On Sun, Jul 19, 2020 at 05:00:33AM -0600, Andreas Dilger wrote:
>>> A couple of tests use perl only for generating a string of
>>> N characters long.  Instead of requiring perl to run a few
>>> tests, use shell built-in commands and don't repeatedly run
>>> a separate subshell just to get a string of characters.
>>> h
>>> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
>> 
>> Thanks, applied.
> 
> .... and I have to revert the patch.  It's using a non-standard shell
> construction which fails on strict POSIX compliant shells, such as
> dash.

Could you please point out which constructs it is unhappy with?  I had
an earlier version of the patch using a different mechanism, but then
updated it after feedback from Lukas.

Cheers, Andreas






--Apple-Mail=_D7AA63F2-4001-454A-B1C4-535974D3B6FD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl92ivoACgkQcqXauRfM
H+D0BA/9GuxjFvp6n3ctt2VnhTV0+UwHhPDFbj7qmaZDjWaBWbddPvwUulHt3rnJ
x3DsxUrLrR5SfRGjnHPBMe+4JIOz4Z5Ok86daEVuR1WPQI+6eupMc1XdbW3QaV0I
ZOOAzYg8kW1TmazzI2y6kXwo+oFFC13eqoUBMnjlUpwVLLQnRsnaTaSD6Vw4V9Fp
XA/SAg323pgDQ147/j+InTl7WkcDULExt/abMjnW1RpOIq2qXKTxEP+dwdpU7a9Y
T+WbMDexuQOF52na8vx9e8yPKnPVci2mOCR4983pnQdVnJ5tQyUWtIMQS0lte0wP
a1YyrS7kE/Bj5vhcbAe8Xx1jYFMNXN5++oPrJTfn5EcBpJAkmBdOPk9WdTfLtdVQ
gFil/raCx+85sS4vRXfLeBWWDYMyWl106QAFLbuUcTCefoXPpI0R71OUrXb5nDjj
fQ6P1gOBCiavYvX9NVI64R56uzJ+4AvNUyPdjGvRg9EJXFy3zExjnfXbC90+xyMm
pZjJ46FRGH84Nkl+geI+k+SiB/EFaWnmigpDkrW/s66Q7bCLRgd/zsZLrI/iH8GJ
U3QwCCWKMAXntPxL79mI43Hp67QOHxpK05kdjs9RcsLQYDhcQBXPLc8yVKpAUW3u
f5WchrT9nBuMUrDQO6CZoMpzD/Q6hp2CrXkQe+DCJw3So0wNwug=
=xMK2
-----END PGP SIGNATURE-----

--Apple-Mail=_D7AA63F2-4001-454A-B1C4-535974D3B6FD--
