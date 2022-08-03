Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7C5886A5
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 06:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiHCEwd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 00:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiHCEwb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 00:52:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D5DFD2
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 21:52:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x39so15201720lfu.7
        for <linux-ext4@vger.kernel.org>; Tue, 02 Aug 2022 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=JmnOmOZ2sbxWYeY24Qkz6pjqCeChon29XTpS/Xvb5V8=;
        b=aUkCkCbonlG+/5lVeMizv+c7RmjCFKloHT0Yel1JCxsfWn3iarslhKAiu4ru8HOf4Y
         xgscYptKmrWv3KNpOaqFyuzWqZV8ERyFxdgBmng/gllcoQHBkp2CrEH97hJE0vpUXOnS
         iDUTNJkmWaozYI5fhNOEW3knRGK/um8uXSnW74yYJwoPiuMoDRppgNWu7AkAn8qa/Gzz
         UzoFueLr933+Qg/ouU6efirUe6CFeoUKHNPiEzYqjp9/9zQ+aTGILk8X3T/v1zdf/leW
         4RKdAz10qTBFBBM8CPQW+0t4fEa6He2r69yYnJ0M6gHEdXTjljeU0RruDTRA2zbiuoAI
         n3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=JmnOmOZ2sbxWYeY24Qkz6pjqCeChon29XTpS/Xvb5V8=;
        b=LI8Qy5QOfe1ZlimKEtPMYw/LQFmaXQVj3F+0jN8b3mrKxV8fAPWngHCLkrXPdip/vy
         8s7s7wt8GWtbBqq2+jMZaOjrIPMtNPJctofzsrKCn/UAf61F0yKYiLYBGENdjyVuze5D
         0Enab3Shlc5umA8axIB+EJutSWUZz1oBGx/WAEzE2ycSrI8yL4as2FQqhtyY/877JtmH
         a0xD2xwcXpDIpI6hJvoI8mBWeuedkgL0e+jPONUY6Ip5k9iG4XUWJYNYWnfXDzpJJ3sd
         rGPxK6UP3cCsObZ0K3NkYPnsCny58b3bDh7M+uLqVCTxNyJ60EqucXGnzcVXA2/el1Ri
         GiBA==
X-Gm-Message-State: ACgBeo0b+IITVuaqWnQG8DJ0LIHIsaQMYnn7P3ShgVqkuT9eMJvxyKTD
        IS0PtEErMQknmngGvWnoNNQ=
X-Google-Smtp-Source: AA6agR4HwyxIR1N3NuxiIUPjEND6KYD9OL6VvrOhYPR2JYuO0pAEcacj8pJtKUsQoiByhs0+KOd0pQ==
X-Received: by 2002:a19:9212:0:b0:48a:e5e1:4582 with SMTP id u18-20020a199212000000b0048ae5e14582mr8103215lfd.474.1659502348389;
        Tue, 02 Aug 2022 21:52:28 -0700 (PDT)
Received: from smtpclient.apple ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id h5-20020a19ca45000000b0048a93325906sm1619445lfj.171.2022.08.02.21.52.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2022 21:52:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [BUG] Tune2fs and fuse2fs do not change j_tail_sequence in
 journal superblock
From:   Alexey Lyahkov <alexey.lyashkov@gmail.com>
In-Reply-To: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
Date:   Wed, 3 Aug 2022 07:52:25 +0300
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linfeilong <linfeilong@huawei.com>, liuzhiqiang26@huawei.com,
        liangyun2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B06D7B3-B867-4A65-BCE3-3E4BF8D72330@gmail.com>
References: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi=20

Thanks for you report.
Problem much bigger than it. Debugs based code lack many parts of =
journal handling, including fast commit.
Journal tag v3, and other.

Alex

> On 2 Aug 2022, at 14:23, zhanchengbin <zhanchengbin1@huawei.com> =
wrote:
>=20
> There are two recover_ext3_journal functions in e2fsprogs, the =
recover_ext3_journal
> function in debugfs/journal.c is called when the programs tune2fs and =
fuse2fs do
> log replay, but in this recover_ext3_journal function, after the log =
replay is over,
> the j_tail_sequence in journal superblock is not changed to the value =
of the last
> transaction sequence, this will cause subsequent log commitids to =
count from the
> commitid in last time.
> ```
> e2fsck/journal.c
> static errcode_t recover_ext3_journal(e2fsck_t ctx)
> {
>    ... ...
>        journal->j_superblock->s_errno =3D -EINVAL;
>        mark_buffer_dirty(journal->j_sb_buffer);
>    }
>=20
>    journal->j_tail_sequence =3D journal->j_transaction_sequence;
>=20
> errout:
>    journal_destroy_revoke(journal);
>    ... ...
> }
> ```
> ```
> debugfs/journal.c
> static errcode_t recover_ext3_journal(ext2_filsys fs)
> {
>    ... ...
>        journal->j_superblock->s_errno =3D -EINVAL;
>        mark_buffer_dirty(journal->j_sb_buffer);
>    }
>=20
> errout:
>    journal_destroy_revoke(journal);
>    ... ...
> }
> ```
> result:
> After tune2fs -e, the log commitid is counted from the commitid in =
last time, if
> the log ID of the current operation overlaps with that of the last =
operation, this
> will cause logs that were previously replayed by tune2fs to be =
replayed here. The
> code used by tune2fs to determine whether to replay the transaction is =
as follows:
> ```
> static int do_one_pass(journal_t *journal,
>            struct recovery_info *info, enum passtype pass)
> {
>    ... ...
>    while (1) {
>        ... ...
>        if (sequence !=3D next_commit_ID) {
>            brelse(bh);
>            break;
>        }
>        ... ...
>        next_commit_ID++;
>    }
>    ... ...
> }
> ```
>    This moment, commitid is "34 c7", commit time stamp is "62 e0 f7 =
a5"
>    004aa000  c0 3b 39 98 00 00 00 02  00 00 34 c7 00 00 00 00 =
|.;9.......4.....|
>    004aa010  4e 93 2f fb 00 00 00 00  00 00 00 00 00 00 00 00 =
|N./.............|
>    004aa020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 =
|................|
>    004aa030  00 00 00 00 62 e0 f7 a5  0a 16 56 20 00 00 00 00 =
|....b.....V ....|
>    --
>    This moment, commitid is "34 c8", commit time stamp is "62 e0 e7 =
1e"
>    004ad000  c0 3b 39 98 00 00 00 02  00 00 34 c8 00 00 00 00 =
|.;9.......4.....|
>    004ad010  75 a6 12 01 00 00 00 00  00 00 00 00 00 00 00 00 =
|u...............|
>    004ad020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 =
|................|
>    004ad030  00 00 00 00 62 e0 e7 1e  18 32 cf 18 00 00 00 00 =
|....b....2......|
>    --
> The probability of this happening is very small, but we do, and I =
think it's a problem.
>=20
> There are two existing solutions:
> 1) Add "journal->j_tail_sequence =3D journal->j_transaction_sequence" =
in to the
> recover_ext3_journal in debugfs/journal.c.
> 2) There is a timestamp in the commit block, so we can add timestamp =
check when
> the log is replayed.

