Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3D7A5602
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjIRXCK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 19:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjIRXCJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 19:02:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBEA6
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:02:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c4586b12feso14877275ad.2
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695078121; x=1695682921; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jv3Op/BGYQS8wbrxKztSz16hdYGUlL80EOHf+c8Dp5U=;
        b=xmMV0bSQ3SJO91qNrtlxbk6kelTFhsNzNXxk4cgPJiVQY7nH4VHdVQpfYcdnZm5HtH
         /iFrVVbDNbzftimnabxbdmlRMRrlNXQrESRpeEApeuJKELCWEZUQ4O1Vf4ZPUqDUX4Tg
         /h8TLwK9/UkT5yAXicVZBXmxRNsujhamMXGKjU0X5jIAXxhfwjVg4Ap5OJKobCU4Uc8x
         HkEMMlGprJ8/tt2mzrK7uJBaIRD9hb6sfl/jmuwaYK5b0gsJOL2TYqh6PEkiKMxz8BVt
         sFknawiTadguRvj3dJB4THmV6geNj8pHXvC4uhXYhvk+AURr+0V4ZEnT1C8upx5m2Sbf
         gNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695078121; x=1695682921;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv3Op/BGYQS8wbrxKztSz16hdYGUlL80EOHf+c8Dp5U=;
        b=uu93UKIuUTM3CA/Teq7XnjrwXzaiOkLjmf+09dx720+nxGMnDvEcpRCLeycZnZtCdD
         13KYWiBHlL1Pgso+LmYnZnXSwf4rPDxBlJB2nLfFq1FuElv0tQn0sxfHhGBH22ZN+TnZ
         OmQXowQH1w29VcDeY5W0S2yNBvb2Zb3jHlZZanvGjf/7qnfgXmNbo2Vqm8MVsZnkItuH
         XYYVOkviAIYe5e9NuzH/MdN0AwTsunTg5VBJ5bp2P8WWCnrGVPQAhdr1mcixK14rkNOW
         XOgPxeCpkYvZN6WgEjyKq2uoJDVRjk83ZqGKm6yQ6sOPPmYh1Eu2X2HNBilqbt+jfx20
         +aVg==
X-Gm-Message-State: AOJu0Yx2FKUMj7W+vDYROrvLV7Y7/5jBiFrG3M35i1q/WNqLgviT6gxl
        LL7yCRYxWd5kWr5rVJt7LB17lQ==
X-Google-Smtp-Source: AGHT+IHlGqWumgBbuD4pfCjL/a9bRgCjjSSuZP4jG4oCrMD7aqGgt0euidQ0hU33RCnhy9h1p01Yzg==
X-Received: by 2002:a17:902:bb96:b0:1c5:61a6:7267 with SMTP id m22-20020a170902bb9600b001c561a67267mr3291618pls.29.1695078121536;
        Mon, 18 Sep 2023 16:02:01 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z14-20020a170902d54e00b001bd28b9c3ddsm8762965plf.299.2023.09.18.16.02.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 16:02:00 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A38E4C3B-F2B9-4EA0-A053-6CDA4F2D5913@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B90D84B9-B9CB-4C2F-92A5-99CE6E5176D9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 4/8] e2fsck: add fast commit scan pass
Date:   Mon, 18 Sep 2023 17:01:56 -0600
In-Reply-To: <130596B4-5BA6-4377-B5CE-0D59FB79878F@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
 <20210122054504.1498532-5-user@harshads-520.kir.corp.google.com>
 <130596B4-5BA6-4377-B5CE-0D59FB79878F@dilger.ca>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B90D84B9-B9CB-4C2F-92A5-99CE6E5176D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

https://patchwork.ozlabs.org/project/linux-ext4/list/?series=3D312552On =
Sep 18, 2023, at 2:39 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Jan 21, 2021, at 10:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>>=20
>> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>>=20
>> Add fast commit scan pass. Scan pass is responsible for following
>> things:
>>=20
>> * Count total number of fast commit tags that need to be replayed
>> during the replay phase.
>>=20
>> * Validate whether the fast commit area is valid for a given
>> transaction ID.
>>=20
>> * Verify the CRC of fast commit area.
>>=20
>> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> I was making a fix to debugfs/journal.c today to improve performance
> of the revoke hashtable, since it was performing very badly with a
> large journal and lots of revokes (separate patch to be submitted).
>=20
> I noticed that debugfs/journal.c is totally missing any of the fast
> commit handling that was added to e2fsck/journal.c in this patch.
>=20
> This seems dangerous since there are some cases where debugfs and =
tune2fs
> will do journal recovery in userspace, but it appears possible that =
they
> would totally miss any fast commit transaction handling.
>=20
> It isn't great that we have two nearly identical copies of the same =
code
> in e2fsprogs, but looks is difficult to make them totally identical.
> We could potentially play some tricks here (e.g. use a common variable
> name for both "ctx" and "fs" in the code, unify copies of =
e2fsck_journal_*
> and ext2fs_journal_* into a single file, and potentially abstract out
> some of the differences (mainly from e2fsck/journal.c fixing errors
> during journal recovery) into helper functions that are no-ops on the
> debugfs/journal.c side.
>=20
> There would still be two different *builds* of the code, with a lot of
> macro expansions to hide the differences, but I think it looks =
possible
> to at least bring these two copies more into sync.  I have some =
cleanups,
> but I don't know much about fast commits and what should be done =
there.

I was poking in ext4 Patchwork for an unrelated reason and found the
following patch series from Alexey Lyashkov that is already cleaning
up a bunch of this code duplication by moving it into lib/support:

https://patchwork.ozlabs.org/project/linux-ext4/list/?series=3D312552

This is cleaning up a bunch of the common code between e2fsck and =
debugfs,
but doesn't get far enough to add in the missing fast commit feature,
AFAICS.

Cheers, Andreas

>> ---
>> e2fsck/journal.c | 109 =
+++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 109 insertions(+)
>>=20
>> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
>> index 2c8e3441..f1aa0fd6 100644
>> --- a/e2fsck/journal.c
>> +++ b/e2fsck/journal.c
>> @@ -278,6 +278,108 @@ static int process_journal_block(ext2_filsys =
fs,
>> 	return 0;
>> }
>>=20
>> +static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
>> +				int off, tid_t expected_tid)
>> +{
>> +	e2fsck_t ctx =3D j->j_fs_dev->k_ctx;
>> +	struct e2fsck_fc_replay_state *state;
>> +	int ret =3D JBD2_FC_REPLAY_CONTINUE;
>> +	struct ext4_fc_add_range *ext;
>> +	struct ext4_fc_tl *tl;
>> +	struct ext4_fc_tail *tail;
>> +	__u8 *start, *end;
>> +	struct ext4_fc_head *head;
>> +	struct ext2fs_extent ext2fs_ex;
>> +
>> +	state =3D &ctx->fc_replay_state;
>> +
>> +	start =3D (__u8 *)bh->b_data;
>> +	end =3D (__u8 *)bh->b_data + j->j_blocksize - 1;
>> +
>> +	jbd_debug(1, "Scan phase starting, expected %d", expected_tid);
>> +	if (state->fc_replay_expected_off =3D=3D 0) {
>> +		memset(state, 0, sizeof(*state));
>> +		/* Check if we can stop early */
>> +		if (le16_to_cpu(((struct ext4_fc_tl *)start)->fc_tag)
>> +			!=3D EXT4_FC_TAG_HEAD) {
>> +			jbd_debug(1, "Ending early!, not a head tag");
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	if (off !=3D state->fc_replay_expected_off) {
>> +		ret =3D -EFSCORRUPTED;
>> +		goto out_err;
>> +	}
>> +
>> +	state->fc_replay_expected_off++;
>> +	fc_for_each_tl(start, end, tl) {
>> +		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
>> +			  tag2str(le16_to_cpu(tl->fc_tag)), =
bh->b_blocknr);
>> +		switch (le16_to_cpu(tl->fc_tag)) {
>> +		case EXT4_FC_TAG_ADD_RANGE:
>> +			ext =3D (struct ext4_fc_add_range =
*)ext4_fc_tag_val(tl);
>> +			ret =3D ext2fs_decode_extent(&ext2fs_ex, (void =
*)&ext->fc_ex,
>> +						   sizeof(ext->fc_ex));
>> +			if (ret)
>> +				ret =3D JBD2_FC_REPLAY_STOP;
>> +			else
>> +				ret =3D JBD2_FC_REPLAY_CONTINUE;
>> +		case EXT4_FC_TAG_DEL_RANGE:
>> +		case EXT4_FC_TAG_LINK:
>> +		case EXT4_FC_TAG_UNLINK:
>> +		case EXT4_FC_TAG_CREAT:
>> +		case EXT4_FC_TAG_INODE:
>> +		case EXT4_FC_TAG_PAD:
>> +			state->fc_cur_tag++;
>> +			state->fc_crc =3D jbd2_chksum(j, state->fc_crc, =
tl,
>> +					sizeof(*tl) + =
ext4_fc_tag_len(tl));
>> +			break;
>> +		case EXT4_FC_TAG_TAIL:
>> +			state->fc_cur_tag++;
>> +			tail =3D (struct ext4_fc_tail =
*)ext4_fc_tag_val(tl);
>> +			state->fc_crc =3D jbd2_chksum(j, state->fc_crc, =
tl,
>> +						sizeof(*tl) +
>> +						offsetof(struct =
ext4_fc_tail,
>> +						fc_crc));
>> +			jbd_debug(1, "tail tid %d, expected %d\n",
>> +					le32_to_cpu(tail->fc_tid),
>> +					expected_tid);
>> +			if (le32_to_cpu(tail->fc_tid) =3D=3D =
expected_tid &&
>> +				le32_to_cpu(tail->fc_crc) =3D=3D =
state->fc_crc) {
>> +				state->fc_replay_num_tags =3D =
state->fc_cur_tag;
>> +			} else {
>> +				ret =3D state->fc_replay_num_tags ?
>> +					JBD2_FC_REPLAY_STOP : =
-EFSBADCRC;
>> +			}
>> +			state->fc_crc =3D 0;
>> +			break;
>> +		case EXT4_FC_TAG_HEAD:
>> +			head =3D (struct ext4_fc_head =
*)ext4_fc_tag_val(tl);
>> +			if (le32_to_cpu(head->fc_features) &
>> +				~EXT4_FC_SUPPORTED_FEATURES) {
>> +				ret =3D -EOPNOTSUPP;
>> +				break;
>> +			}
>> +			if (le32_to_cpu(head->fc_tid) !=3D expected_tid) =
{
>> +				ret =3D -EINVAL;
>> +				break;
>> +			}
>> +			state->fc_cur_tag++;
>> +			state->fc_crc =3D jbd2_chksum(j, state->fc_crc, =
tl,
>> +					sizeof(*tl) + =
ext4_fc_tag_len(tl));
>> +			break;
>> +		default:
>> +			ret =3D state->fc_replay_num_tags ?
>> +				JBD2_FC_REPLAY_STOP : -ECANCELED;
>> +		}
>> +		if (ret < 0 || ret =3D=3D JBD2_FC_REPLAY_STOP)
>> +			break;
>> +	}
>> +
>> +out_err:
>> +	return ret;
>> +}
>> /*
>> * Main recovery path entry point. This function returns =
JBD2_FC_REPLAY_CONTINUE
>> * to indicate that it is expecting more fast commit blocks. It =
returns
>> @@ -286,6 +388,13 @@ static int process_journal_block(ext2_filsys fs,
>> static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
>> 				enum passtype pass, int off, tid_t =
expected_tid)
>> {
>> +	e2fsck_t ctx =3D journal->j_fs_dev->k_ctx;
>> +	struct e2fsck_fc_replay_state *state =3D &ctx->fc_replay_state;
>> +
>> +	if (pass =3D=3D PASS_SCAN) {
>> +		state->fc_current_pass =3D PASS_SCAN;
>> +		return ext4_fc_replay_scan(journal, bh, off, =
expected_tid);
>> +	}
>> 	return JBD2_FC_REPLAY_STOP;
>> }
>>=20
>> --
>> 2.30.0.280.ga3ce27912f-goog
>>=20
>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20


Cheers, Andreas






--Apple-Mail=_B90D84B9-B9CB-4C2F-92A5-99CE6E5176D9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUI1uQACgkQcqXauRfM
H+CCvg//dG/zHD7WwA7op3wevLImY+iuteFe4HLklTMnRtU4zC43qCnYGlbXP/Z5
dDSd0cKD/eEAEbuKAeN9AzLdH35igaoAuLaDwoPnfbMmq9urIwDtbN39FkLdZpa0
dYdyvpYUZPVBktdy2nqh9zS9MZNokAYwWDA5+g+4PJ0lRHvUiwCqmPL43l/aV8Rz
gv1SHMWZZtK4dYRhZnO7EDgMDLNKuKDlyhFszLTOHLx4YjCGgfKht19goXoyhvn7
wVXUZvSWA4i2PoNshLt1/W0qYkSv/+n7h0jbf4H/DcNxt2IQplVFTWsORZzmMFCr
1n3aR2hydeti5RQPgKuc+k4u6BBE1YILQgEU48p3r5i6bjBtnD4n3YgHgrlWj9pB
Wj6jgPV/o6EpDAsEtuNCMKzRd9l9gK7p8SjAVIz8A3mqi3wpg+SzoPzkoJ27tyFK
aKmvjVz0uddQ3AEpetAabOodkJhHZ2bRr577ZyPTOIvuxr5J1S7s0dg1sxqzFiTw
GIJclQINT+x/Z0lvlrEv70Sx0dsJxuimGKr7f7V9+UJlrK+c3cuThX82wZou5Y3/
771h9jdjPmwgRPKx92rsbiVWE1sc/3uWenivMJdiBzJig5o/bzVc4y/OwT70P7vt
FrUw7jXEGxUs6fmaGpRuvSJUrYFkthik5I7aj5wGQ3LdgOuLpiA=
=KyqX
-----END PGP SIGNATURE-----

--Apple-Mail=_B90D84B9-B9CB-4C2F-92A5-99CE6E5176D9--
