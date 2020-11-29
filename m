Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB92C7B67
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Nov 2020 22:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgK2VeX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Nov 2020 16:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgK2VeX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Nov 2020 16:34:23 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E8C0613CF
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 13:33:37 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id q3so1096201pgr.3
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 13:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=j1mzJgVm1GHIoECHCQwHi+uXZkqvVTzfyfH6iFkj9+8=;
        b=A4TjhVJo3DVhRos8kyeahOHj5RDu49AkoxJXgtl3Xan31v+XVLPUxd+zHURW6YfXX/
         b8WdvnD7Uve7GS6xZROIfhsp/sY++nq9MocpH6t+AW8EqnVfqUXKixsZy0pgmRVJBWSf
         gdVAGjs4yO8/mZrDoD8HoLsANS3CHM2fZxaCKH6KWuCyVdJTr1ODQbWA+yJiOo93LyUN
         nkPIcxMOHcetsouWasYn3Y9TUFkSuYQwL64uQDNC+DOs5wRLFxwnpqlGoI3gnXXEq8hE
         klqXqNXtXtuaZQVthJPDweoAAVlgUqQJzVMQIpQ1GWuXk5vO2xCjprN11GZ+8YHAwrdk
         2Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=j1mzJgVm1GHIoECHCQwHi+uXZkqvVTzfyfH6iFkj9+8=;
        b=mEBlp7biCQeX1iDHIowZxoDxthgtfpEW3yN9HorZySKILzby3ajsnGtz9axD1XDvp2
         /pO5zELJfiBADRrzVoF8lB61FACs1eNuNfNhT6RKY49tv17BB4tlH6SsZFyNNr4X4lR+
         6KKHCEg9sOOqtdKv/MWlFGXqk7m15zfqRCv7GNjrpC0aWGkizYyb7miWSiT3+675wAkU
         578rRr8CERYUJPamNEe0nPJXCYsgK7CCXsbfB+UP1giBJsHH8wX/1YLZfcEFi2ldwSK6
         7DA51MaYAGeYrWK+TrMDYm0eXHuWVp1XzHhiHU5Nawmx9ZPLIY39xmpxXTGqbd2O5DXc
         ATRw==
X-Gm-Message-State: AOAM532uqEgOShp6xYgkaT236HOeqmaA4tNmJ79PRvMySkZy5v04r8lI
        xB2qXTlwFgfaQ0VQ5jG3EjnvCA==
X-Google-Smtp-Source: ABdhPJyzGzVC4Id0C19bzWrx6Tk6zVpJfMp+/UQiNVSE6VZLavGqFzZL6bw+JdsjmiTTWV2eFFVjIQ==
X-Received: by 2002:a17:90b:3505:: with SMTP id ls5mr22770413pjb.55.1606685617131;
        Sun, 29 Nov 2020 13:33:37 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s7sm12517910pju.37.2020.11.29.13.33.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 13:33:36 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AEF7E6AA-9663-4470-A689-FD55062EC8CA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_98B24CEE-383F-42F0-B1F3-F7FD945F01F1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/12] ext4: Don't remount read-only with errors=continue
 on reboot
Date:   Sun, 29 Nov 2020 14:33:35 -0700
In-Reply-To: <20201127113405.26867-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_98B24CEE-383F-42F0-B1F3-F7FD945F01F1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
> 
> ext4_handle_error() with errors=continue mount option can accidentally
> remount the filesystem read-only when the system is rebooting. Fix that.
> 
> Fixes: 1dc1097ff60e ("ext4: avoid panic during forced reboot")
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 94472044f4c1..2b08b162075c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -666,19 +666,17 @@ static bool system_going_down(void)
> 
> static void ext4_handle_error(struct super_block *sb)
> {
> +	journal_t *journal = EXT4_SB(sb)->s_journal;
> +
> 	if (test_opt(sb, WARN_ON_ERROR))
> 		WARN_ON_ONCE(1);
> 
> -	if (sb_rdonly(sb))
> +	if (sb_rdonly(sb) || test_opt(sb, ERRORS_CONT))
> 		return;
> 
> -	if (!test_opt(sb, ERRORS_CONT)) {
> -		journal_t *journal = EXT4_SB(sb)->s_journal;
> -
> -		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
> -		if (journal)
> -			jbd2_journal_abort(journal, -EIO);
> -	}
> +	ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
> +	if (journal)
> +		jbd2_journal_abort(journal, -EIO);
> 	/*
> 	 * We force ERRORS_RO behavior when system is rebooting. Otherwise we
> 	 * could panic during 'reboot -f' as the underlying device got already
> --
> 2.16.4
> 


Cheers, Andreas






--Apple-Mail=_98B24CEE-383F-42F0-B1F3-F7FD945F01F1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/EE68ACgkQcqXauRfM
H+Dx4w//WPpL0S1/ArRhK21o+CVIFZiZkQD8vt+VLQENYPiXaZHby3RCl5YgzemH
n6C2pJ5l4cZ/ZP7pBB73rH96RusG9z3ktSL+ftcCDlSwtlTqitvtgb72dASiDqf0
gNArH581TVDAZqHVLjljF7yd+VgQXYI5xl/I+a+WjGUjjmd2pbB7F2Yir5jvwHry
JYVYHjPtnWRdZ7elghf36q1Y2gzUBY3f8ZbiQa1csJuSiuemJZzhqStgc1ITU/KM
yUfNZ7TrNvU7IarmZPW4o1pVnkl6CuC+gFuZRuW6Jsmsdjwwt+We8PyhRHvtAIAZ
tineav6DI/KHEpxoEhlYrZugH2tMASN48ktMkYJE80qFsPdSyWwENdvXttrS5Das
9V/qFmCCP5cCEDDsI07HYhEIzUPwxNs2jOf/9GvNFaUT23KveWQqETFA09Mq9/vZ
mQussBpwZy0AUtdZeYGx3um761iKiiXWYmKtCfYt6M3UKRZUGfA5X9jHDqqLpOB6
CJAHkDOHnUwyK8D60a7dPHyNVomOHkKl5QE53DEUKUe4iVbNpLvr4WdED9+i8dac
4hs6sNXOET7xanUj9k2dKp85Ks1Rn7EWTSkDCz1+6hd8w2wmZyzPi23t8MT1tRnD
ScPht47ksDiPTOePg24vPeLxGd7bVu62pQB/gjPTg9W7DJG5hsA=
=0Btj
-----END PGP SIGNATURE-----

--Apple-Mail=_98B24CEE-383F-42F0-B1F3-F7FD945F01F1--
