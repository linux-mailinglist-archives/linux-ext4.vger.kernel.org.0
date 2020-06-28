Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9E20CADA
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgF1WFM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Jun 2020 18:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgF1WFL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Jun 2020 18:05:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56AC03E979
        for <linux-ext4@vger.kernel.org>; Sun, 28 Jun 2020 15:05:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so6333947ple.0
        for <linux-ext4@vger.kernel.org>; Sun, 28 Jun 2020 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=CpyWnROy0g/owP6uB2Am51D8tqvXotMCgwyTNgqOsoU=;
        b=0gtbP7aWtciJzqNmoU1y90esl66w1+QokMxLD2SAfOquuoeY8mlKcbM0pYL8CrPkTd
         ApY0fF30EKobT5XCeHOQme8zpZh0LgZBzS8D73oUtn9ZhQDscMFBYqWCyESIvJVSe0Up
         bptJK8fhuuVG9K5/Ddp/H5iWAn7jp5N83bmQ6xRqq/jLGTG7sipmZdLoB1lbTKC9OAa2
         xZcn0BZicr0UpUYE+Vd9Vw2P5LUAyHLIsvZeZWDqzggifOgjJi+fxT3w0KAsiB4t/Y1o
         zSQVu5rnREkjUwPP8cHjmRYZool0qbI+dN64E69Mb279f+QO6Ljb1jjZzwcodgdAvvSR
         SRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=CpyWnROy0g/owP6uB2Am51D8tqvXotMCgwyTNgqOsoU=;
        b=RYz7tPYtJAjOoqmMFimytmvrJgVeZABQ8jmOZ7s+61f+036UDG4bHpGbfwwA4n1fu8
         xFiKlWp8ldWCKivJyeH9HQJb6SEZ6m7E5iwRCssaZ9s6rgjSmgGtN99ymk+7QwWlYBUR
         tbuYKY68JumcGDPtVohv+S+LxjJNhy5PCPyTjT8hW/4MfvFwIrAmo42T3SI0nseMpNFD
         zf6stgIBqDTuhKi57nkbXTpFpRb9O1aOIwy/9cBxF6s0qi3rc7ZJojvt4aLlShJN66Qg
         Ba0odopxjyqPU75hOj/6ZK2Ub4Kx3ZxRJ8noX/im3yWfaiIFGQwkcOWxpKOweiT5Y1Mw
         FbUA==
X-Gm-Message-State: AOAM530vJHH509R0QShNbr4YZG6+Hi+4ROZjLjJv7JTBjMuSkW1oOn7R
        KAz1cTw0DOqsK0UYWRdyIwp9hw==
X-Google-Smtp-Source: ABdhPJzxd8DmdlkDSdAzyRBS51zhUgUJcqz4GL8QGIdnifGIiV7TwkFUvXsVviOs98B1rCm8A6npHA==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr3479290plk.313.1593381911094;
        Sun, 28 Jun 2020 15:05:11 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t1sm11154555pje.55.2020.06.28.15.05.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jun 2020 15:05:10 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <100913BE-A164-4904-B2F0-C8558B5A1397@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5B905246-5202-42EE-A9F1-685E69D300F3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: lost matching-pair of trace in ext4_unlink
Date:   Sun, 28 Jun 2020 16:05:34 -0600
In-Reply-To: <20200628034852.85502-1-zhuangyi1@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Yi Zhuang <zhuangyi1@huawei.com>
References: <20200628034852.85502-1-zhuangyi1@huawei.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5B905246-5202-42EE-A9F1-685E69D300F3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 27, 2020, at 9:48 PM, Yi Zhuang <zhuangyi1@huawei.com> wrote:
>=20
> If dquot_initialize() return non-zero and trace of =
ext4_unlink_enter/exit
> enabled then the matching-pair of trace_exit will lost in log.
>=20
> Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>

Thank you for the patch.  It definitely looks like this is fixing the
problem with trace exit, but I would recommend to use a better name
than "out_unlink:" for the label.  I was looking at the ext4_unlink()
function, and found it confusing that there is already an "end_unlink:"
label and these two names would be easily confused.

Please change your new label to be "out_trace:", or similar, which
makes it more clear that it is undoing the "trace" part of the code.

It looks like there is another similar problem with the error handling
in this function:

	bh =3D ext4_find_entry(dir, &dentry->d_name, &de, NULL);
	if (IS_ERR(bh))
		return PTR_ERR(bh);
	if (!bh)
		goto end_unlink;

At this point the journal handle has not been started, and the PTR_ERR()
return is also missing the trace exit, so it would be better to change
these two cases to use the "out_trace:" label as well, like:

	bh =3D ext4_find_entry(dir, &dentry->d_name, &de, NULL);
	if (!bh) {
		retval =3D -ENOENT;
		goto out_trace;
	}
	if (IS_ERR(bh)) {
		retval =3D PTR_ERR(bh);
		goto out_trace;
	}

Could you please resubmit your patch with these small changes.


There could be a separate small patch to split up the "end_unlink:"
label to be two separate labels, and then remove the "if (handle)"
check, and then use out_bh: before the handle is started:

        if (le32_to_cpu(de->inode) !=3D inode->i_ino) {
		retval =3D -EFSCORRUPTED;
                goto out_bh;
	}

        handle =3D ext4_journal_start(dir, EXT4_HT_DIR,
                                    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
        if (IS_ERR(handle)) {
                retval =3D PTR_ERR(handle);
                goto out_bh;
        }
	:
	:

out_handle:
	ext4_journal_stop(handle);
out_bh:
	brelse(bh);
out_trace:
        trace_ext4_unlink_exit(dentry, retval);
        return retval;

Cheers, Andreas

> ---
> fs/ext4/namei.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 56738b538ddf..5e41d45915c9 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3193,10 +3193,10 @@ static int ext4_unlink(struct inode *dir, =
struct dentry *dentry)
> 	 * in separate transaction */
> 	retval =3D dquot_initialize(dir);
> 	if (retval)
> -		return retval;
> +		goto out_unlink;
> 	retval =3D dquot_initialize(d_inode(dentry));
> 	if (retval)
> -		return retval;
> +		goto out_unlink;
>=20
> 	retval =3D -ENOENT;
> 	bh =3D ext4_find_entry(dir, &dentry->d_name, &de, NULL);
> @@ -3255,6 +3255,7 @@ static int ext4_unlink(struct inode *dir, struct =
dentry *dentry)
> 	brelse(bh);
> 	if (handle)
> 		ext4_journal_stop(handle);
> +out_unlink:
> 	trace_ext4_unlink_exit(dentry, retval);
> 	return retval;
> }
> --
> 2.26.0.106.g9fadedd
>=20


Cheers, Andreas






--Apple-Mail=_5B905246-5202-42EE-A9F1-685E69D300F3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl75FC8ACgkQcqXauRfM
H+DJ/w/+I/SAikDjIKcTOr+HPgUpfjCpyFqhxGYg6ectxvrYN/kYReDl7bv1yAza
ioW+i7dgavUJWirVrCGhrMcH16LUsE1mmlSPyMCv8aKhw09J8kcRBNJr6SIGMe0a
rfnES/d3sPzGjWVpCcAGAlRjN/0VquLvhwpvS5kEjnR2GaO10iTAXYunCywCbh4J
wHrwK2JlTUrlQ15XhpasImAjRdsEoU96le4TS7V/TRwQtwt26hciBvB8WvzdbPQ/
+EhkeiBw6FIhWR2mXaqvkYXFZ34dLyZ1lPNeXH48d+Qf7TbkujoC67KxLgS6L/Cf
zoUW9kf1la+I4zUdZDbCI2oaJ7DHQ6lcl4+wR0IROh19WDgHFbf9BFFknn/eFLD2
tQOuBJzz6o7MJuFFYEfhj9VGaVq3+YXR73K40D+LqPZkkd4TAVAcNLU15NYwR6qP
k2Yw4YMBWAPyBWTJk9M71ltiS02Z6rwR//NoXCsIHBkgSC7NbDuuTc03Lg1CM+vV
IFom7ttAMbT8LdanlrcaBcC9tzA+6w83Xc7a5F1IQRC+WJ3Dv/GIiSsQ4BM8vY8Y
CG8og8LpLcziwBk+5Sw3WqmcSxAEcMThjtqBLkCsr3sgTYhoRUlBigXgXc30vJZg
3IiMyRxdPWZAoxcpJteHguEoUArWZIUITgXX3qrJZcwQRc8I+m0=
=oQ3t
-----END PGP SIGNATURE-----

--Apple-Mail=_5B905246-5202-42EE-A9F1-685E69D300F3--
