Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC53A7177
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 23:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhFNVlE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhFNVlD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Jun 2021 17:41:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5DC061574
        for <linux-ext4@vger.kernel.org>; Mon, 14 Jun 2021 14:39:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n12so9733915pgs.13
        for <linux-ext4@vger.kernel.org>; Mon, 14 Jun 2021 14:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BtcpnIzsJLqObkrg/CrsvrsXXV5nCwiJdNO8S1bsLTs=;
        b=skBlNjiLoMVcFnIgl7ESKwvni/Llq/JVPSwnilL8XMhKavZYSqyEZyVEUp33Gmiw01
         MiZp60lSwB5xsr3s2r3orNwMWcbcVtZe5gU5zJz3UEd2XIWznDFVnK1xYCxxuaX3aSKw
         pV4FjSddA8LjYQs5cImrHLCJlBaONI1kh1NtV6CwvWwr6XFUcvgdFDV0nf6wrhTLKjGE
         MHMK9WuUSQftN3mzQnh3YGqicl5gXQp2DVF3E4R8O5CKhNwlQcdxbB7asRTPibg0Ablx
         lRAmVA/PQULwuzj01dMJZ/Kz+smb8ZtoNmQrNZsa/LEAXOz2U7nE0ZAD1bvR5pKBzMan
         fs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BtcpnIzsJLqObkrg/CrsvrsXXV5nCwiJdNO8S1bsLTs=;
        b=rvoXN2vLcMeUVTKBTwRP7S3oR4hFpV0R5DPxGmVKfADctosCWfty1qL5e66PRk9pbh
         HV7zWUyCaEqhG9RloTsh95N0lqFpi7niymzplc4uuiWK+Oso78i+ldRB/azQafmt81Dw
         nllCaFBMEfiJAry4yY8PteKaddh8KQ3Ab9hevxK9Yt08pLZ++ax3h3oQJTQ+XKv4LuIM
         NId73MZ3sp2i66B3+1jeZ6brVqnzBLV0AWLYzCKZjFKNrPAqFxp14EqfLh90GuRM+I1C
         X8rmUkioJvUVP82qmjWG7G+KPXfwYa3J+k0pxBIFjgeVJHLES7EhBZ4UvPyUZjN06grn
         Y4QA==
X-Gm-Message-State: AOAM530KHsQtRw5Pk5Cu2odu062fUx7EfPmMn91IXnUmkqIC7yLl22RA
        Pn8G864htbelHK/NfmOqmKVrWRvhD3m9jz/1
X-Google-Smtp-Source: ABdhPJwrGz46+uBb4M0LAO6ok7/QbUNwsIec3DsvPg4Ft+wHdpLHOy4kTnI/nd6IA0lThzuln0hqIA==
X-Received: by 2002:a62:687:0:b029:2ef:be02:c346 with SMTP id 129-20020a6206870000b02902efbe02c346mr1177973pfg.51.1623706740108;
        Mon, 14 Jun 2021 14:39:00 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 78sm13933596pgg.73.2021.06.14.14.38.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jun 2021 14:38:59 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E6977B7F-091D-40E9-B0CD-BB3D8B7FE287@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_147D5790-F59C-43A1-A974-B38D291CB2E0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tune2fs: Update overhead when toggling journal feature
Date:   Mon, 14 Jun 2021 15:38:57 -0600
In-Reply-To: <20210614212830.20207-1-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>
References: <20210614212830.20207-1-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_147D5790-F59C-43A1-A974-B38D291CB2E0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Jun 14, 2021, at 3:28 PM, Jan Kara <jack@suse.cz> wrote:
> 
> When adding or removing journal from a filesystem, we also need to add /
> remove journal blocks from overhead stored in the superblock.  Otherwise
> total number of blocks in the filesystem as reported by statfs(2) need
> not match reality and could lead to odd results like negative number of
> used blocks reported by df(1).
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

You could add:

Fixes: 9046b4dfd0ce ("mke2fs: set overhead in super block")

and

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

That also makes me wonder if resize2fs also needs to recalculate or
invalidate the s_overhead_clusters field when adding new block groups.
It *looks* like that is done correctly in adjust_fs_info() already?

Cheers, Andreas

> ---
> misc/tune2fs.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 4d4cf5a13384..2f6858abda32 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -396,6 +396,8 @@ static errcode_t remove_journal_inode(ext2_filsys fs)
> 				_("while clearing journal inode"));
> 			return retval;
> 		}
> +		fs->super->s_overhead_clusters -=
> +			EXT2FS_NUM_B2C(fs, EXT2_I_SIZE(&inode) / fs->blocksize);
> 		memset(&inode, 0, sizeof(inode));
> 		ext2fs_mark_bb_dirty(fs);
> 		fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
> @@ -1663,8 +1665,12 @@ static int add_journal(ext2_filsys fs)
> 			com_err(program_name, retval, "%s",
> 				_("\n\twhile trying to create journal file"));
> 			return retval;
> -		} else
> -			fputs(_("done\n"), stdout);
> +		}
> +		fs->super->s_overhead_clusters += EXT2FS_NUM_B2C(fs,
> +			jparams.num_journal_blocks + jparams.num_fc_blocks);
> +		ext2fs_mark_super_dirty(fs);
> +		fputs(_("done\n"), stdout);
> +
> 		/*
> 		 * If the filesystem wasn't mounted, we need to force
> 		 * the block group descriptors out.
> --
> 2.26.2
> 


Cheers, Andreas






--Apple-Mail=_147D5790-F59C-43A1-A974-B38D291CB2E0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmDHzHIACgkQcqXauRfM
H+DSmRAAsn4WXOjfLRFijDrm4pFXWHmWAhAQet37kto9ufipVzqCVPI9P9/HjYH2
WWikCdQPCszQbvJtSSJ9h7yG33ivlEGWqELJUqqLdcK6lXeU4tZ3lupbkR+Dvygg
G7NXqtUzarIGE2+HH1t0eF7rtOVW3QCnKASujxaoLeYMVi9wrtXvuIcXLR3kZ+9V
am1kdeR8/BOQke/UL16yqsPTl46DOCqPsdKZ/5fHFlhPKtlUwPly0CAmTz0p/kG4
Hak0THBQFBJbOkwyRk/8zH0oHPFwJqNu3otlPYPBJbBiT91xRa1GjDS1bTsjf3E5
ZA4hTiSUAXy218s3kr6E8qAmxfEBxGtTfr9zGWwRgCtJMA9Es8HXe1GQUfsbn//K
iruxseTVahmJV4vqO6YYI3gbATc20RKQ6n22oYYqsGpwPp7BH2ieQU+Gb5uiGgEs
EA8Txvi6uSTKKOcScIpfAwGWMmF2UU6LCh8ORRaYudIMa1TMCRLrAee+lPT8cBY+
FGcrsIUdFVIxuOooRJXfdhiCCDdAZ/01uIeagXEYWT4M+2g6phNRAJ1aTw6l7E4d
He9T+uslHa+2GdOLT3I4So4JG0HfoFK4CbFJvJSqIaXYxwCnVDxGT4YFLEd4runY
m9h8u68PFAjFGYoTeMs8DIwGwipO+BNCX+SmtnKGLDVgFwBktNw=
=NVAF
-----END PGP SIGNATURE-----

--Apple-Mail=_147D5790-F59C-43A1-A974-B38D291CB2E0--
