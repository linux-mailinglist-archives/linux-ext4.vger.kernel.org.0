Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005328846B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHIVLR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 17:11:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46974 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHIVLR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 17:11:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so45401185plz.13
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ST1hZZfCMitS6lP+7TFhPOr4rSIAJnH8Al4WNiWNw9E=;
        b=yrUjbQ64MSqj5i5a6MZ/Hl3FyOGdwPY/gpV9EjW5y4yYPp0YVSDSAZwAXc12rLwb5K
         hU/RV2niryphY8zWEIgTbSoWi1z9eu0LmCflDK94MIbzTzTE0d4GQolOpGyXP1OTc2M/
         y3YDwCMtpUaMKJj7JShtrwcemnmHZS5Wj+34J79aPV0pThOTIgGyuk5ZVg7RvFoG2M/N
         IqztWXCQDqhL64k8/vVDh0GrrcfBAO3ONk7Vg5A9m8AfiTiVFO93vnNz4yLUWa2W4cL8
         eYgEotgvPfM4hjmFn6iMST6/0zx28UKMmrt8t3LfhP8qx+rgWOVJqn5r2XuxyJhuzXqG
         MR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ST1hZZfCMitS6lP+7TFhPOr4rSIAJnH8Al4WNiWNw9E=;
        b=MRIXdoVhRgRLDGRw/EvyUCed7fkuJpVsqmk2htytiRCj59gWpteZpPewZJhpQwIoam
         j3SleKfic8a7AUYVTGYlSXhblO298Rk+qWGXhRLyq1tTK3rktITr8hEQHVg6Du5d7mWa
         zuvdLeYhhNGItdq9ZcckGkkV5V1BIoeRVEo810ecSPOIL3svMlHNjf6VNbHhBDitXFgm
         4R6D29aABMZ/bnWoZlko80VHGyqGx2m0/F/i3kNNWjQdo/Cpc39ZqTbvlvuOYS/pL1Vc
         BYE7ET8Q7XYXufRaNHqAXRRbs1eVX93sMUKv0wmNqH07ygNZOSd2k7xB6CiQ+1PWOA4i
         gtPg==
X-Gm-Message-State: APjAAAUMDZTVd2a00a2KFbe8juT53TFUskyXQCxj7XZfsHvl4uerH4oJ
        +dt7uFtEIo+NXfSQWK8kTJEm+w==
X-Google-Smtp-Source: APXvYqwcPUofGFM2qzOFvUhTCwYq4h5yRHDy4m9oeA2MfcmW0SUns7nQlxMO3LMLHO/9mtq2ami3Ig==
X-Received: by 2002:a17:902:6a88:: with SMTP id n8mr20911938plk.70.1565385075796;
        Fri, 09 Aug 2019 14:11:15 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id o95sm5760888pjb.4.2019.08.09.14.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:11:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D5F6A0C1-D139-4BF9-B8C4-FE673D9CEBA4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C36934F4-DBE3-467F-B03F-42689AE2E1E7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
Date:   Fri, 9 Aug 2019 15:11:13 -0600
In-Reply-To: <6DBCC366-02CC-4F2A-AA16-EC4587261699@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-6-harshadshirwadkar@gmail.com>
 <6DBCC366-02CC-4F2A-AA16-EC4587261699@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C36934F4-DBE3-467F-B03F-42689AE2E1E7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Aug 9, 2019, at 2:38 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>>=20
>> This patch adds new helper APIs that ext4 needs for fast
>> commits. These new fast commit APIs are used by subsequent fast =
commit
>> patches to implement fast commits. Following new APIs are added:
>>=20
>> /*
>> * Returns when either a full commit or a fast commit
>> * completes
>> */
>> int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
>> 			    tid_t tid, tid_t subtid)
>>=20
>> /* Send all the data buffers related to an inode */
>> int journal_submit_inode_data(journal_t *journal,
>> 			      struct jbd2_inode *jinode)
>>=20
>> /* Map one fast commit buffer for use by the file system */
>> int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
>>=20
>> /* Wait on fast commit buffers to complete IO */
>> jbd2_wait_on_fc_bufs(journal_t *journal, int num_bufs)
>>=20
>> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>>=20
>> +int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
>> +{
>> +	unsigned long long pblock;
>> +	unsigned long blocknr;
>> +	int ret =3D 0;
>> +	struct buffer_head *bh;
>> +	int fc_off;
>> +	journal_header_t *jhdr;
>> +
>> +	write_lock(&journal->j_state_lock);
>> +
>> +	if (journal->j_fc_off + journal->j_first_fc < =
journal->j_last_fc) {
>> +		fc_off =3D journal->j_fc_off;
>> +		blocknr =3D journal->j_first_fc + fc_off;
>> +		journal->j_fc_off++;
>> +	} else {
>> +		ret =3D -EINVAL;
>> +	}
>> +	write_unlock(&journal->j_state_lock);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D jbd2_journal_bmap(journal, blocknr, &pblock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	bh =3D __getblk(journal->j_dev, pblock, journal->j_blocksize);
>> +	if (!bh)
>> +		return -ENOMEM;
>> +
>> +	lock_buffer(bh);
>> +	jhdr =3D (journal_header_t *)bh->b_data;
>> +	jhdr->h_magic =3D cpu_to_be32(JBD2_MAGIC_NUMBER);
>> +	jhdr->h_blocktype =3D cpu_to_be32(JBD2_FC_BLOCK);
>> +	jhdr->h_sequence =3D =
cpu_to_be32(journal->j_running_transaction->t_tid);
>> +
>> +	set_buffer_uptodate(bh);
>> +	unlock_buffer(bh);
>> +	journal->j_fc_wbuf[fc_off] =3D bh;
>> +
>> +	*bh_out =3D bh;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(jbd2_map_fc_buf);

One question about this function.  It seems that it is called for every
commit by ext4_journal_fc_commit_cb().  Why does it need to map the fast
journal commit blocks on every call?  It would make more sense to map =
the
blocks once at initialization time and then just re-use them on each =
call.

Cheers, Andreas






--Apple-Mail=_C36934F4-DBE3-467F-B03F-42689AE2E1E7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1N4XEACgkQcqXauRfM
H+ACUA//f+xQkdOWKGCWGryOICZkM9x3u8NCSatFAFwoMZPgA3wKWg0SQhBAsLkV
TrFyoU2TyyJX9xJndDjsPyQeOEEdyPAnfd+IM+KKMjf5s1OlilCloHHdtEdJB0Do
W6LFKgPYhJYxeK2QNR/CIKqyv0viXCbPmj2Pe7YWYr0r/TD+SdHbfncVt7tzAAqh
QFXryUj4RtbCZmIsb/uGc4f5SwIDdFau+pmLK0il9xdi7zvpNQv/blXNsIUjnP2I
P6fBAshJNIhHYvCELcDG4Jjmig2XIGSKNq7oLWB3EeCWUE3p+vhWliGKkHPvYfDk
M45X+v1YhA6CrEtRsZQA/tfU3zc5ac51pO2SlRKEMZ9vT91GZ65I7bcRMlDXdqUS
M/DXMgrPg+SgJ3yW6OtC4SPAkmZu9Oc1HgtkUa1YAMeabAXlcLYaIm0FkipvQWO5
QBCFBUndkBN7LcFYRRMEkI0zPxk/0YtNAuQKO1iFYRGn1n8QBpOCjKGEpTxc3sqA
8bMsQFPtJDHroW17+opSJm5kLIIBtck9k7a5R0iTTlImSCAmAQV7OLvsoMt+Kif5
yawJt6IymdKu1A9GyvtHaKxUOSx2cafPtF3hgS1q0mLEf6WpbRheaWftP/5vqsgq
UBKudkbc0HwrPxfx8us/kTJTeLPWKfy3Q2EaYy6zb802Xo639pw=
=Xx+r
-----END PGP SIGNATURE-----

--Apple-Mail=_C36934F4-DBE3-467F-B03F-42689AE2E1E7--
