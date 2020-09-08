Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94E262338
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Sep 2020 00:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgIHWsh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Sep 2020 18:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgIHWsd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Sep 2020 18:48:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90090C061573
        for <linux-ext4@vger.kernel.org>; Tue,  8 Sep 2020 15:48:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d9so414040pfd.3
        for <linux-ext4@vger.kernel.org>; Tue, 08 Sep 2020 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JJBC+dRsWx19fxnTrxyYD1s4Dh/9MfBc48gk9kmR18w=;
        b=HDgI0QqEdRhiQ/DNiVepuZWax/p0swNpVcDQPiEjYU6pptrJQUdva4blsdA+QK8SBE
         q18PAyIdT+BIC3VaxZCxmiaHxO3+9ctCjG9axVrtZIKlnHZwRW39mJ3kUwHQsoO2Aghy
         jfXuIM06pnhURHwkLb/j4lIW1C/yYDJ3OoQ2tJY7b4CQvX5eUXMhMns1BYpz74xT0Yvj
         5Jve7d9sdlDV3MCEOpQJWyQsuxik69z75avtNTCmN5o5Hj6Ha/66SvSxvbn76n3YrY+R
         bLOPvoclZwkBxoKHG4lQdpXmAcAj6tGVIwcZUtndffka5wlFiSzm0W4+J8adp1QJUTaE
         eKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JJBC+dRsWx19fxnTrxyYD1s4Dh/9MfBc48gk9kmR18w=;
        b=MKBxUF0cO/+fpWZzdAdiqbuyr/2GGTHy8fUsS01MzvmmoTFmtM9CTOzRk8+otyr+KY
         TLfiokw4O6nfOumfT7woLI5Qa6Af/Zcr08cDSvqGXUu0fexGP5O1zb5pmaDCWEt458p9
         zBS7vczSsBMbHXFnNZed4Ba+ntZIfyFL0P0fgbVgETS5QvDUBmTmrr65vBcASX3us5vS
         fwvXzGmiWmJEHQjgzI/gToJJNLEzq+ZF9Zt8jcpWTaOcd63J2Xcx3P2FLbbBlr2SqhFJ
         q/Ul9z1F2qbSFOzCJ85u236k3c3Kw1wO9HtPNzUQ6pRdxz7EzxGJNw065NtfB1pGjX7/
         6DTA==
X-Gm-Message-State: AOAM5334bJ9C50TgY7lBldWHAFgD8J7wRxW6KfNRyP8awoCe7S8v2PA7
        oQK95nW4YWPVmBMxZVeqQNYIFQ==
X-Google-Smtp-Source: ABdhPJyIxNjNoj3zNv04AtjNHwzx2PAMmqjrX4JFccJ29pdLx75uWPoleJp9fQdjOLOhJBYFUhjpVg==
X-Received: by 2002:aa7:99c7:0:b029:13e:d13d:a056 with SMTP id v7-20020aa799c70000b029013ed13da056mr1158896pfi.28.1599605311306;
        Tue, 08 Sep 2020 15:48:31 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j14sm275737pgf.76.2020.09.08.15.48.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 15:48:30 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <62F2BFF6-6FF4-4283-95E0-F79A48AD7A2E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8B141A62-05B2-4AC8-A386-2DA372BF6213";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] jbd2: fix descriptor block checksum failed after
 format with lazy_journal_init=1
Date:   Tue, 8 Sep 2020 16:48:26 -0600
In-Reply-To: <02cc0284c5cb4c4f9cb5282302807bc2@hikvision.com>
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.com" <jack@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@hikvision.com>
References: <02cc0284c5cb4c4f9cb5282302807bc2@hikvision.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8B141A62-05B2-4AC8-A386-2DA372BF6213
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 8, 2020, at 2:51 AM, =E5=B8=B8=E5=87=A4=E6=A5=A0 =
<changfengnan@hikvision.com> wrote:
>=20
> After the last commit, I found that some situations were not =
considered.
> In last post, I only considered the case of descriptor block checksum =
failed,but there is others situations.

Thank you for the updated patch.  There are several things that need to =
be
fixed before the patch can be accepted:
- the whitespace of the patch is broken, since it looks like all tabs =
are lost
- the patch summary should be shorter than 64 characters, maybe like:
  "jbd2: avoid transaction reuse after reformatting" or similar, and =
then
  put a more complete description in the commit message
- the patch commit message should be shorter than 70 characters.  It =
would be
  much easier to read if you aligned the transaction blocks vertically, =
down
  the page, instead having such very long lines, like:

     case 1 journal        case 2 journal        case 3 journal
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  [journal superblock]  [journal superblock]
  [ transactions
      ....
        ....         ]
  [ descriptor block |
  |   data blocks
      ....
        ....         |
  |   commit block   ]
  [ more transactions
       ....
         ....        ]

- the commit message should describe only the patch itself, not the =
previous
  version of the patch or general comments.  Other comments can be =
written
  in a separate email that is a reply to the patch itself.
- please run your patch through "checkpatch.pl" to find any style issues
- you need to add a "Signed-off-by: =E5=B8=B8=E5=87=A4=E6=A5=A0 =
<changfengnan@hikvision.com>" line
  or maybe "Signed-off-by: =E5=B8=B8=E5=87=A4=E6=A5=A0 (Chang Fengnan) =
<changfengnan@hikvision.com>"

Some general comments on the patch inline.

> for example:
>=20
> if you format with lazy_journal_init=3D1 first time, after mount a =
short time, you reboot machine, the layout of jbd2 may be like this:
>=20
> journal Superblock|     [ transactions..... ]      |descriptor_block | =
data_blocks|  commmit_block | descriptor_block |  data_blocks| =
commmit_block|[more transactions...
> -------------------------|     [some transactions]   =
|-------------------       transaction x          =
-----------------|-----------------          transaction x+1         =
---------------|
>=20
> and after reboot, you format with lazy_journal_init=3D1 second time, =
after mount a short time, you reboot machine again, the layout of jbd2 =
may be like this:
>=20
> 1.
> journal Superblock|     [ transactions..... ]       |descriptor_block =
| data_blocks|  commmit_block | descriptor_block |  data_blocks| =
commmit_block|[more transactions...
> -------------------------|     [some transactions]   |---------------  =
        transaction x       ---------------------|
> 2.
> journal Superblock|     [ transactions..... ]       |descriptor_block =
|  data_blocks | data_blocks  |    data_blocks   | commmit_block| =
commmit_block|[more transactions...
> -------------------------|     [some transactions]   =
|-----------------------------------               transaction x         =
         --------------------------------|
> 3.
> journal Superblock|     [ transactions..... ]      |descriptor_block | =
 data_blocks | data_blocks  |    commmit_block | data_blocks | =
commmit_block|[more transactions...
> -------------------------|    [some transactions]   =
|--------------------------------     transaction x           =
----------------------------|
>=20
> In case one and two,will be recovery failed. So there is another =
patch:
>=20
> fs/jbd2/recovery.c | 60 =
+++++++++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 55 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a4967b27ffb6..56198c2c1a04 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -33,6 +33,8 @@ struct recovery_info
> intnr_replays;
> intnr_revokes;
> intnr_revoke_hits;
> +int transaction_flag;

(minor) This should be an unsigned int, and there should be a #define'd
constant to describe what "0x1" means instead of using "0x1" in the =
code.
However, it may be better to make this "ri_commit_block", see below.

> +__be64  last_trans_commit_time;
> };
>=20
> enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
> @@ -412,7 +414,27 @@ static int jbd2_block_tag_csum_verify(journal_t =
*j, journal_block_tag_t *tag,
> else
> return tag->t_checksum =3D=3D cpu_to_be16(csum32);
> }
> +/*
> + * We check the commit time and compare it with the commit time of =
the previous transaction,

Please wrap lines at 80 columns.

> + * if it's smaller than previous, We think it's not belong to same =
journal.
> + */
> +static int is_same_journal(journal_t *journal,struct buffer_head *bh, =
unsigned long blocknr, __u64 last_commit_sec)

(minor) return type should be "bool"
(style) Wrap at 80 columns.

> +{
> +int commit_block_nr =3D blocknr + count_tags(journal, bh) + 1;

(defect) "commit_block_nr" should not be a signed int, or it may =
overflow
(style) it would be good to use a consistent naming for the block
number and the buffer head, like:

	unsigned long commit_block;
	struct buffer_head *commit_bh;

> +struct buffer_head *nbh;
>=20
> +int err =3D jread(&nbh, journal, commit_block_nr);

(style) blank line after variable declarations

> +if (err)
> +return 1;

(defect?) Should the checksum of commit_bh be verified before use?
Otherwise, this may be a random block in the journal that has some
value > last_commit_sec, and not a commit block at all.  However,
it may be enough to avoid this extra commit block checksum by storing
the commit block number as ri_commit_block, and then checking it
is correct when the commit block is later processed.

> +
> +struct commit_header *cbh =3D (struct commit_header *)nbh->b_data;
> +__u64commit_sec =3D be64_to_cpu(cbh->h_commit_sec);

(style) no variable declarations in the middle of functions

> +
> +if(commit_sec < last_commit_sec)
> +return 0;
> +else
> +return 1;

(style) no need for "else" after "return".  That said, this function
could just return the boolean comparison value directly:

	return commit_sec >=3D last_commit_sec;

> +}
> static int do_one_pass(journal_t *journal,
> struct recovery_info *info, enum passtype pass)
> {
> @@ -514,18 +536,31 @@ static int do_one_pass(journal_t *journal,
> switch(blocktype) {
> case JBD2_DESCRIPTOR_BLOCK:
> /* Verify checksum first */
> +if(pass =3D=3D PASS_SCAN) {
> +info->transaction_flag =3D 0x1;
> +}

(style) no need for {} around single-line block
(style) could this instead store the block number of the logical commit
block number that is referenced and verified by this descriptor block?
That would be better than just storing the "0x1" flag, to verify that
the proper checksum/timestamp was used by the descriptor block?

I had to re-indent the below code to understand the logic, but I think
I did it correctly.

> 		if (jbd2_journal_has_csum_v2or3(journal))
> 			descr_csum_size =3D
> 				sizeof(struct jbd2_journal_block_tail);
> 		if (descr_csum_size > 0 &&
> 		    !jbd2_descriptor_block_csum_verify(journal,
> 						       bh->b_data)) {
> -			printk(KERN_ERR "JBD2: Invalid checksum "
> +			=
if(is_same_journal(journal,bh,next_log_block-1,info->last_trans_commit_tim=
e)) {

(style) wrap lines at 80 columns.

> +				printk(KERN_ERR "JBD2: Invalid checksum =
"
>  				       "recovering block %lu in log\n",
>  				       next_log_block);

(style) console error strings should *not* be wrapped at 80 columns, so =
it
can be found more easily in the code (e.g. grep for "checksum =
recovering"
should be able to find this line of code).  This code was written before
the "do not wrap error strings" rule was added, but should be updated to
follow the new code style if modified.

> -			err =3D -EFSBADCRC;
> -			brelse(bh);
> -			goto failed;
> +				err =3D -EFSBADCRC;
> +				brelse(bh);
> +				goto failed;

> +			} else {
> +				/*if it's not belong to same journal, =
just end this recovery, return with success*/

(style) wrap at 80 columns

> +				printk(KERN_ERR "JBD2: Invalid checksum =
"
> +				       "found in block %lu in log, but =
not same journal %d\n",
> +				       next_log_block,next_commit_ID);

(style) do not wrap error strings
(minor) this shouldn't really be printed as an "error" to the user, =
since
it isn't an "error" at all, only a bad coincidence or a short =
transaction?
This should probably only be a jbd_debug() message or similar?

> +err =3D 0;
> +brelse(bh);
> +goto done;
> +}
> }
>=20
> /* If it is a valid descriptor block, replay it
> @@ -688,6 +723,17 @@ static int do_one_pass(journal_t *journal,
>  * are present verify them in PASS_SCAN; else not
>  * much to do other than move on to the next sequence
>  * number. */
> +if(pass =3D=3D PASS_SCAN) {
> +struct commit_header *cbh =3D
> +(struct commit_header *)bh->b_data;
> +if(info->transaction_flag !=3D 0x1) {

(style) This should check "info->ri_commit_block" to verify that this =
block
is the correct commit block, which is safer than just checking "flag !=3D =
0x1".

> +jbd_debug(1, "invalid commit block found in %lu, stop =
here.\n",next_log_block);
> +brelse(bh);
> +goto done;
> +}
> +info->transaction_flag =3D 0x0;
> +info->last_trans_commit_time =3D be64_to_cpu(cbh->h_commit_sec);
> +}
> if (pass =3D=3D PASS_SCAN &&
>     jbd2_has_feature_checksum(journal)) {
> int chksum_err, chksum_seen;
> @@ -761,7 +807,11 @@ static int do_one_pass(journal_t *journal,
> brelse(bh);
> continue;
> }
> -
> +if (pass !=3D PASS_SCAN && info->transaction_flag !=3D 0x1) {
> +jbd_debug(1, "invalid revoke block found in %lu, stop =
here.\n",next_log_block);
> +brelse(bh);
> +goto done;
> +}
> err =3D scan_revoke_records(journal, bh,
>   next_commit_ID, info);
> brelse(bh);


Cheers, Andreas






--Apple-Mail=_8B141A62-05B2-4AC8-A386-2DA372BF6213
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9YCjoACgkQcqXauRfM
H+BYeBAApoxOc1v1+ZD30kgSWuNhIIR1+OmTaXY+mHTLSbUExhkZD5XslJOhpVVn
w/XoGKQyrti6O20klIp5WYXBZUtSVqjihKghKGTTxUhGez5BNf44GdZg7LGV58FD
0GpGKElRDXu7HwKjPbbdzhhTexw4g90uG6/8WfHpg2PQcauwlVCWX4522MabiCC3
KYKdcEqxxcTpH2oe4nwv+kbG7/sr2FqIRuZo/IxF8Wmh0V2vMpscwTzLWd4HcOBo
g9VfQwivyJ6ESJhzTUtmzGZtA2Sa8O7ykTRKnbZyEq76Gk5MbDkm0+tj27gcKM/y
wRwpAjhta2358DexZ3ugbsjEZqdAyDhh+pT9JjE5uU6ooPOBtG7z0B5U799ShnWU
d1C0Iz/gz+O50jgetbGmMfTdc7UULnOHqENS17E+VLsorWYonYVLsZPCXb2yFDzy
2Mjlhos3cdWftA8Z6Ax/f4yKCev5pFuBQ9IjWqj/DAd0TuHkUdzoJEc6PU7ejl6C
a2oSysxjUtOI3Edv+TJoeqOV1kcimnsF8g0XM9amTMZ3KeOwhb9++dz/mt8rFSBE
Pa7hDZkwmLsv/ikPIUCHDGpZrD02snURcN+3Zk4BWxOlW0vOSveNQMk78deZGTh4
y1//b8owXxdkxYfgA2SuVDRt81ZZX87s5ytjMMJycD1T3YK3/+U=
=77Jo
-----END PGP SIGNATURE-----

--Apple-Mail=_8B141A62-05B2-4AC8-A386-2DA372BF6213--
