Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3DB56CAF0
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Jul 2022 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiGIRcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Jul 2022 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIRcb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Jul 2022 13:32:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC93F322
        for <linux-ext4@vger.kernel.org>; Sat,  9 Jul 2022 10:32:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bf13so1451154pgb.11
        for <linux-ext4@vger.kernel.org>; Sat, 09 Jul 2022 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Hd+jxdYlPRTftGgI/r1AVp3I0/DH9hb2m7geG5qamOQ=;
        b=UYCi4WQePisihOcOLqqXmKAboJ+b3e9lk3LH83aQ//6s355c5SmVIIMffxgmkP3mBB
         URRzDIhJlRGQHPXIlT0l7PH+k0VVPczCi5Ojk4P7IOxA7KE5VjSIp0t/CGMx6EnPbX4Q
         h+k5UeFhcvsLddbwG6d03l3vA1Buyt94O8kKcypOHCzk1paW3ypXV9qVj8N/qijDNg5t
         kVvNVq+Y5dK40Ft8pVg2QTRAkwGbo9FMhJN+xe4nzzUAe3Y6eZbNfzusQI+jvKG92W2t
         VtDbf9dJ+RI+KLJSN/CzZfxZ41jYZqfh5JsAQFUHLq/QeNRQXzPBfaXE/DtN1l1+hOF1
         M5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Hd+jxdYlPRTftGgI/r1AVp3I0/DH9hb2m7geG5qamOQ=;
        b=jxDXq7Cc/rXWpr0ImZxtgzc1hMyiibSSMvKq/k3Nor2s6IGeO29Kr0f70s0MOhnm7u
         WU4ZzFRGHD/XpL+/XsEYqgoAhUCyAjzcJ7qi5izN1sAIzOU/2QhgU7Jy9QIjJv2lUhTY
         uitvaI7zO4aAMg5mSKOmGTSWqOfSfSee78mFaRtXnBALQHFbAvDv5twxTIPTjFY/Wm3W
         8NkvqQPJJqYyzgaoJ8Xwq3M8Ov6RKgTSpXu0PhxszssogtKCe8hIuAfRONzOodPp5cn+
         zj7l1O3Lo0IzLTU29jZp9aIg7Zfw034W7QLq5O2tFC4CJ7wUq01evdZTDBf4ujdXhwfl
         Uubw==
X-Gm-Message-State: AJIora9Bt31UjgXtqv+GotI4Nez1KJfyXqjgfGb8NXbigaoX4DGIjm11
        GLp7sCTPdBKP5F/2dm5J0E+FbQ==
X-Google-Smtp-Source: AGRyM1sx9ce+6PbF6V09hXTBdQC0eO4MRO5igTs+RBEnG/OnXP3OtM9YFo3VGZ5xqugftbhmAi59Dg==
X-Received: by 2002:aa7:961d:0:b0:528:ce2b:d9ce with SMTP id q29-20020aa7961d000000b00528ce2bd9cemr10032125pfg.83.1657387950016;
        Sat, 09 Jul 2022 10:32:30 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016bfa097927sm1566100pln.249.2022.07.09.10.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jul 2022 10:32:29 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F009F595-F69B-4430-BF18-71E4EE022883@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A451005F-E4D4-4CC2-9FCC-5394C1B6028F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: make sure ext4_append() always allocates new
 block
Date:   Sat, 9 Jul 2022 11:32:28 -0600
In-Reply-To: <20220704142721.157985-2-lczerner@redhat.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
References: <20220704142721.157985-1-lczerner@redhat.com>
 <20220704142721.157985-2-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A451005F-E4D4-4CC2-9FCC-5394C1B6028F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 4, 2022, at 8:27 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> 
> ext4_append() must always allocate a new block, otherwise we run the
> risk of overwriting existing directory block corrupting the directory
> tree in the process resulting in all manner of problems later on.
> 
> Add a sanity check to see if the logical block is already allocated and
> error out if it is.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/namei.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cf460aa4f81d..4af441494e09 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -54,6 +54,7 @@ static struct buffer_head *ext4_append(handle_t *handle,
> 					struct inode *inode,
> 					ext4_lblk_t *block)
> {
> +	struct ext4_map_blocks map;
> 	struct buffer_head *bh;
> 	int err;
> 
> @@ -63,6 +64,21 @@ static struct buffer_head *ext4_append(handle_t *handle,
> 		return ERR_PTR(-ENOSPC);
> 
> 	*block = inode->i_size >> inode->i_sb->s_blocksize_bits;
> +	map.m_lblk = *block;
> +	map.m_len = 1;
> +
> +	/*
> +	 * We're appending new directory block. Make sure the block is not
> +	 * allocated yet, otherwise we will end up corrupting the
> +	 * directory.
> +	 */
> +	err = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +	if (err) {
> +		EXT4_ERROR_INODE(inode, "Logical block already allocated");
> +		return ERR_PTR(-EFSCORRUPTED);
> +	}
> 
> 	bh = ext4_bread(handle, inode, *block, EXT4_GET_BLOCKS_CREATE);
> 	if (IS_ERR(bh))
> --
> 2.35.3
> 


Cheers, Andreas






--Apple-Mail=_A451005F-E4D4-4CC2-9FCC-5394C1B6028F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmLJu6wACgkQcqXauRfM
H+AzHg//YXzwe+48F/DAaRhWAgmIQAcJ9Bk2sbeVf+DPJEb6iQx9H0hP169pgyIo
d7ImGAg5Rs79KNCmgSQ1Wja6M09T1k4VqydNcwymaDn9iOWbMhuPt+9U+kG+gQIc
gFGBPtn8AIulwgtXDJxU1umrqrWqtDuaoiCToYo8RSWnTL+cmkh9660RP980kTlb
O0VA/4VliFDqj+gg0gmEHyd99cCdP4griDf3IYSniNjBSSYwolZoEGY726qXcN4R
muwqL1BG5hVXqHpoMlcCNiFJi8yHQ9T49d5+DhxvgGkHzZ1dRy/zXBtUmT4K/Dr5
egbj5Rdv1EgdsH8zAQaGYElKtR3Pjm5IpFbpMDXuZ7svpQsJ0hIXwOvlg9YiDue1
ti8kho6CiprT1V3xjDbkFkki9K3laZnWbiEOZ5veocFz2m2A6CjupDzuVW3ZJEZP
EBjP3RmpeqBGgDYlSq7Yb+RxhoNzXm0TF8mvd76uIfF3YeaoOQlx4B/jNTiYOUSK
kGk1awTM731KRt4xNcl6GlGs+1dO5X8oLUYxe2RHgIQKIqRWONE7d5MDis+XyoYC
x9QVgrSBgLaMMo1AWv9KbD3xGKJJwqLZW/5UN4JESLYB3pNd07tqcizaE2+MjC+b
hX2H/Uqw3O5vWF4GhBbK22NkbzkSPtfcK9vdx0Q5S68FF72HviU=
=TNPc
-----END PGP SIGNATURE-----

--Apple-Mail=_A451005F-E4D4-4CC2-9FCC-5394C1B6028F--
