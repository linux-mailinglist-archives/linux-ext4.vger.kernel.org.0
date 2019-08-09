Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0584588333
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHITSO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 15:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfHITSO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Aug 2019 15:18:14 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6D020C01;
        Fri,  9 Aug 2019 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565378293;
        bh=V50NPzVIFID7+N11LsAcTtnVPDvnuMIUCgv3KYlYbMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eraxla2pgkFcSxlq2xBM8hK4GdnEMtRmyztBRGEVrjOmk1vxZTU0rL3peGEFRg8c8
         WevzrhPex7wuCdn2HwMG1g0yhkdwPPODQsTVcSXuaNNZvPv59iQ2P4c74f3HtyYiah
         nVdmVRsCo7x9oQSUdp1soRWmYvMUhUdEyE9E20hQ=
Date:   Fri, 9 Aug 2019 12:18:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: add a new ioctl EXT4_IOC_GETSTATE
Message-ID: <20190809191810.GA100971@gmail.com>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20190809181831.10618-1-tytso@mit.edu>
 <20190809181831.10618-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809181831.10618-3-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 09, 2019 at 02:18:31PM -0400, Theodore Ts'o wrote:
> The new ioctl EXT4_IOC_GETSTATE returns some of the dynamic state of
> an ext4 inode for debugging purposes.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/ext4.h  | 11 +++++++++++
>  fs/ext4/ioctl.c | 17 +++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f6c305b43ffa..58b7a0905186 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -651,6 +651,7 @@ enum {
>  #define EXT4_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
>  /* ioctl codes 19--2F are reserved for fscrypt */
>  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 30)
> +#define EXT4_IOC_GETSTATE		_IOW('f', 30, __u32)

30 == 0x1e overlaps with the range claimed to be reserved for fscrypt.

Also, these two new ioctls are both number 30, which means they can't be
controlled separately by SELinux, which only looks at the number.

- Eric
