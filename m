Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1B175D14
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2020 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCBOav (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Mar 2020 09:30:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41819 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727104AbgCBOav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Mar 2020 09:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583159449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1J78esZek10gdcwTEnZSNgPNzbhLFNph5NyKb7TZY0=;
        b=e2rMONqWjKuFkeHmmUxrgigow5DDxPyCOgOsavquNhrwxAFyVYcImT+CBPWVv2IHXUSixR
        zoVPxrot6LddM2eYZlGEnuTXbuMVTcaMtHQtPnLJr7NoGcqNMAipH9ToB3914dIi38x/dR
        /HkT7wFM5cuvgfKz/mPjElUeBgjajM8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-51tIseXDMICJ_ZXCiIXkmA-1; Mon, 02 Mar 2020 09:30:48 -0500
X-MC-Unique: 51tIseXDMICJ_ZXCiIXkmA-1
Received: by mail-wr1-f71.google.com with SMTP id w11so1680223wrp.20
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2020 06:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=o1J78esZek10gdcwTEnZSNgPNzbhLFNph5NyKb7TZY0=;
        b=gF3QSA9Sr8IYtmlHI0j2E+14fhSAP/6VjAgPIUsLKS252U08Cbu1DKZE7ZCrbsxjRo
         RxITZ/QzZNZrPH7iio5//0up3YVZOra/A2T7K9tqU3Se3aVy+lY8kCrwwhKmDxJkTv3O
         m9G6dXTHPnd1KwOqJEm2GscKbroLIzbvqkUsNsNk0m1oSQTe04MJ5rXZcUxxtVADyuhh
         HZ/FkoO6DkaA1bjUVkVUdbwHdb1mmt7CT7f6MUIs51jgGqK0dj6aUD3mOGmj5yy5QL/K
         cfpywd3VF3ER7rF1MhiDTdhIr+dmtFbLqR/zA8esA6RT1zcEsIkJc3/6EuAqlk2qhsZ+
         m7QA==
X-Gm-Message-State: APjAAAU9KUzxUILgmF5TQ/30PGP9Bh9T0qGlUa9/yKra/y3pEyvzlc5d
        EjlSUCNMdfR14FxEYsoW/jMj+ZyBLOAHoSK/UFgN9rnI/tbysJHXZ7BgYjwEKcl1bkf/YON8GJu
        LvgDvbj18nk5zVabpA0M7YA==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr20451889wmh.85.1583159446734;
        Mon, 02 Mar 2020 06:30:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy53hnDM7QwkuW4L8bAFASEO8YbDgfHu8DVeuuOlv1SIY8Pp0BxJJvfRSGa8tq14okfEu2Jmw==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr20451868wmh.85.1583159446498;
        Mon, 02 Mar 2020 06:30:46 -0800 (PST)
Received: from andromeda (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id i67sm4789608wri.50.2020.03.02.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:30:45 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:30:43 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] libext2fs/ismounted.c: check open(O_EXCL) before mntent
 file
Message-ID: <20200302143043.h2p3zpbf6t4qfkxk@andromeda>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Zdenek Kabelac <zkabelac@redhat.com>, Karel Zak <kzak@redhat.com>
References: <20200225143445.13182-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225143445.13182-1-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 25, 2020 at 03:34:45PM +0100, Lukas Czerner wrote:
> Currently the ext2fs_check_mount_point() will use the open(O_EXCL) check
> on linux after all the other checks are done. However it is not
> necessary to check mntent if open(O_EXCL) succeeds because it means that
> the device is not mounted.
> 
> Moreover the commit ea4d53b7 introduced a regression where a following
> set of commands fails:
> 
> vgcreate mygroup /dev/sda
> lvcreate -L 1G -n lvol0 mygroup
> mkfs.ext4 /dev/mygroup/lvol0
> mount /dev/mygroup/lvol0 /mnt
> lvrename /dev/mygroup/lvol0 /dev/mygroup/lvol1
> lvcreate -L 1G -n lvol0 mygroup
> mkfs.ext4 /dev/mygroup/lvol0   <<<--- This fails
> 
> It fails because it thinks that /dev/mygroup/lvol0 is mounted because
> the device name in /proc/mounts is not updated following the lvrename.
> 
> Move the open(O_EXCL) check before the mntent check and return
> immediatelly if the device is not busy.
> 
> Fixes: ea4d53b7 ("libext2fs/ismounted.c: check device id in advance to skip false device names")
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reported-by: Zdenek Kabelac <zkabelac@redhat.com>
> Reported-by: Karel Zak <kzak@redhat.com>
> ---

...

> +			if (fd >= 0) {
> +				/*
> +				 * The device is not busy so it's
> +				 * definitelly not mounted. No need to
> +				 * to perform any more checks.
> +				 */
> +				close(fd);
> +				*mount_flags = 0;
> +				return 0;
> +			} else if (errno == EBUSY)
> +				busy = 1;

			^ I think you are supposed to use {} for the 'else if'
			  branch too, once the first branch uses it

Other than the small coding style above, which depends on maintainer, the code
looks ok, and you can add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

Cheers


> +		}
> +	}
> +#endif
> +
>  	if (is_swap_device(device)) {
>  		*mount_flags = EXT2_MF_MOUNTED | EXT2_MF_SWAP;
>  		strncpy(mtpt, "<swap>", mtlen);
> @@ -386,21 +410,8 @@ errcode_t ext2fs_check_mount_point(const char *device, int *mount_flags,
>  	if (retval)
>  		return retval;
>  
> -#ifdef __linux__ /* This only works on Linux 2.6+ systems */
> -	{
> -		struct stat st_buf;
> -
> -		if (stat(device, &st_buf) == 0 &&
> -		    ext2fsP_is_disk_device(st_buf.st_mode)) {
> -			int fd = open(device, O_RDONLY | O_EXCL);
> -
> -			if (fd >= 0)
> -				close(fd);
> -			else if (errno == EBUSY)
> -				*mount_flags |= EXT2_MF_BUSY;
> -		}
> -	}
> -#endif
> +	if (busy)
> +		*mount_flags |= EXT2_MF_BUSY;
>  
>  	return 0;
>  }
> -- 
> 2.21.1
> 

-- 
Carlos

