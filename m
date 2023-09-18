Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9887A5513
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 23:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjIRVbz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIRVbz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 17:31:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CB90
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:31:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso4407794b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695072708; x=1695677508; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qtu/TLm5ocKMYlZ3wLmV6QsCaTKGX/MyT6VaHbLe2s=;
        b=QgXkhKzZomZQpbchZPjrIgWLqhqoMBugiqPWZP35/4Ae9V/k/Fjf+CWFEJ4b1n35+H
         E8pb9uJaijIbS8xHFOdu6ZluIRnLcKBrVd27OglMnurC1J4fkDKmjh0o4d0z8rhfO4qu
         O5dXXnDT4MdVDjotoqSnom8bwz0aQ+kEnqvKhG1gjqDsFBgnt0UiN5LhiI5Ms7V6q/Aa
         +ySFwUIqQxpMYi7A10tUVEZ3BM+LA7pTIJNu6GRHxPeWh8xV69ZfKhbwADHhyGcIyeFO
         IwxAX+0fYUkN92IWFd7qQgwsFz9LLqm66/Hbk6gZMHNvsCTs6kauT83DweWGofSkx481
         X/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695072708; x=1695677508;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qtu/TLm5ocKMYlZ3wLmV6QsCaTKGX/MyT6VaHbLe2s=;
        b=JtttpqGC5H1GEW/4uO5w35+pG4VY8f1CqQYtt9bADXnlSSYr59Ndfj/ttXWeKf8eGi
         ThR18ormVp4k9vfjaMo+uFxtp2g5AaSPXEahiiYXja4CJJV9kN4me0Lnht2Zqn4+Ivsd
         ZkXTp1M8fPITKRmT24Apxdsf5jUt6lcOrOHzQI8GocPcuI3BklijY8F8ZzL2qX/ZOlXl
         7ESSD769UYqrMutCSiFx6ypY1Emv7t8BculJgnQ//IWyO1rAGDdHQbfzUTMoAz4Vya6x
         61URB30dv0HkhaCDb7Ntru7CUPsW9qnIXcpqXp5eZMrxbvO57IaaQTx4bsig00gAz52T
         4MVA==
X-Gm-Message-State: AOJu0Yxpmq62H0P/9bp/jQO43VsSyLYk+RraMKfeCa+GXRBqFkSIM8I5
        ES71HVWCX4Q/BKWX1Q1FP0y0TQ==
X-Google-Smtp-Source: AGHT+IHpXIWmEpuLIkhq/pKTCuJp5kHzKjHgYPw8ZmGkH1U7NKZA28b8WdT2Pi+4k+zw44t1uEwSQw==
X-Received: by 2002:a05:6a00:1588:b0:68a:5e5b:e450 with SMTP id u8-20020a056a00158800b0068a5e5be450mr12630865pfk.26.1695072708173;
        Mon, 18 Sep 2023 14:31:48 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i3-20020aa78d83000000b0068be7119c70sm7488874pfr.186.2023.09.18.14.31.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 14:31:47 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D3085B08-C2D9-43BE-9ACD-FDCCEE9CAB82@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_24FE7AED-C8F3-421E-A3A5-8319533E4982";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 4/8] e2fsck: add fast commit scan pass
Date:   Mon, 18 Sep 2023 15:31:44 -0600
In-Reply-To: <130596B4-5BA6-4377-B5CE-0D59FB79878F@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>, tytso@mit.edu
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


--Apple-Mail=_24FE7AED-C8F3-421E-A3A5-8319533E4982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 18, 2023, at 2:39 PM, Andreas Dilger <adilger@dilger.ca> wrote:
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
> I noticed that e2fsck/journal.c is totally missing any of the fast
> commit handling that was added to in this patch.

Sorry, this became incorrect during editing - the debugfs/journal.c
file does not have any of the fast commit handling that was added to
e2fsck/journal.

Cheers, Andreas

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
>=20
> Cheers, Andreas
>=20
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


Cheers, Andreas






--Apple-Mail=_24FE7AED-C8F3-421E-A3A5-8319533E4982
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUIwcAACgkQcqXauRfM
H+BD6Q//ez94FGN/z3OkSRf7Cdu6sS6XtxRVCC8Y2sAnSeHBuWIfN2H2SqoWb8ba
u0Ob45MJX4dqJmMXRcGYYtX2BqNP9V8xz+uCEKDM6E2TKiQHtSRxe2NichDi2V3S
0dwOBOpvf7g8FmjCDOVtkt7okoCjYQS93QWnVsuHxq3pLhBB1An4rSA7fdvALv/o
f+E+Qp8ht81hinhi462QWjxs+jrSL/Yz1LXc4gFJkOPuRB0ZupcmqQp3+Vqi7Eu1
aSAgk++8kt8PX9XHvEFKxFWmNQgWDPJBQFz0NdNheoAneojrxpv8qfztpgO+ev07
YduBb8W+ChQuSzoBSCXf7QbrbhsuVcCa9UwMUhL570xyCUz+ndclAW0ctFlPdo/i
0TuLA/3zlztiz0fB7Qnq7lCVg3c2pF3eP4xyoW/52A/Wzbu/Jj/mDWhmC/vUeZsl
6N/UIkToEpDEV2dO33chzRvGvG3ZGKip8WR8311MUOGBI6FL3jWgF7rQfiu4KTw7
b6uXAsGE6wogWNyWiqMACKMGv2zIX6MpBYAxgUBAW5HVg5sjG9EVUBV0NzXBfyfp
dY72nQ2wY3peknT0xGxSyPb+s44bM25oqT5gNXGZLp/a+Xrx2dIqDu6TAmLUREE8
N538zGHRNX/rMkONL/yyoTYog3PLt+y4UHxDyjrOJpW7XeY2GFU=
=C3fk
-----END PGP SIGNATURE-----

--Apple-Mail=_24FE7AED-C8F3-421E-A3A5-8319533E4982--
