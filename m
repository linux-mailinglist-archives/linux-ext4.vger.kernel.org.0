Return-Path: <linux-ext4+bounces-10652-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CFBC3152
	for <lists+linux-ext4@lfdr.de>; Wed, 08 Oct 2025 02:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1996B3C6437
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Oct 2025 00:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EF9287508;
	Wed,  8 Oct 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht+7uV4b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513C2874F6;
	Wed,  8 Oct 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759884438; cv=none; b=Wgy1k/NPCoSQYKp7gAJ2ESB774qBMsnlF8uwCmQsdnacJTDzkoMOQJ48qdml0aWiQoKvSWMbMwzLzpxUvSQLlfYmDnj74+jzTQcBXCjPd9dLNtXIkM/LCGRTPKOn8J7Gzl8Sy1fioefxB+3nBDrEwYqZBo/kbxo1PfVttSrPihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759884438; c=relaxed/simple;
	bh=YxZh3W+XSiyq1owAkNfMx7aVLQPQxF4PtBRHasFhUrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4M0XLU9VtgP41YATFoCuT8XwtV19/OHvJEMR3Inl+9JsivSsH1UZkUnRr03S2I6kXoYjtIt4gniNo2jbx6cJezzLS6jITazqt1LnGkyRvFSXb8EGM1HlisnKPiM1bIWRy+caCMR7GiYwC9rg+Nb3V+u96SplxyAkpu721Fe060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht+7uV4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D38C4CEF1;
	Wed,  8 Oct 2025 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759884438;
	bh=YxZh3W+XSiyq1owAkNfMx7aVLQPQxF4PtBRHasFhUrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ht+7uV4br8p5eS8cfZ0/0cIbG8A64P3Y5kUVIzk71eQtPq2pvYQgwdFfB1e4tp1de
	 Oc5Po6LZOuJysaprDDc+yK3RBzz1U3IRbh3xzYjUvUGpPOqiWoYvPnDQ3/oPNvpQr9
	 zuRlw2ysYcrgH/ytYO4qCia2dvPyTHpI2NKUbtcrrQJ4uJHJOI1lLYRsXndm9beFTF
	 9zbMDhV4iFCM8bb6fn9OqyWhOTXaR7CmDzLk1Fv/puEAoRMInH8CDJc5ALoof/mtv3
	 xI8slQ+8j54XbL48LlCp1kM3gJwcvf6E+cVi8+mMm8A4EKZH4k/Fd8lDqYpLVfZR8I
	 0CwtMQXY3r4eA==
Date: Tue, 7 Oct 2025 17:47:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH] Fix: ext4: add sanity check for inode inline write range
Message-ID: <20251008004717.GL8084@frogsfrogsfrogs>
References: <20251007234221.28643-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007234221.28643-2-eraykrdg1@gmail.com>

On Wed, Oct 08, 2025 at 02:42:22AM +0300, Ahmet Eray Karadag wrote:
> Add a simple check in ext4_try_to_write_inline_data() to prevent
> writes that extend past the inode's inline data area. The function
> now returns -EINVAL if pos + len exceeds i_inline_size.
> 
> This avoids invalid inline write attempts and keeps the write path
> consistent with the inode limits.
> 
> Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com> 
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
>  fs/ext4/inline.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 1b094a4f3866..13ba56e8e334 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -782,6 +782,16 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  	struct ext4_iloc iloc;
>  	int ret = 0, ret2;
>  
> +	if ((pos + len) > EXT4_I(inode)->i_inline_size) {
> +			ext4_warning_inode(inode,
> +				"inline write beyond capacity (pos=%lld, len=%u, inline_size=%d)",
> +				pos, len, EXT4_I(inode)->i_inline_size);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		ret = -EINVAL;
> +		goto out;

Shouldn't write_begin have converted the file to block format if the
range to be written exceeds the possible inlinedata size?

> +	}
> +
>  	if (unlikely(copied < len) && !folio_test_uptodate(folio))
>  		copied = 0;
>  
> @@ -838,8 +848,8 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  	 */
>  	if (pos + len > inode->i_size && ext4_can_truncate(inode))
>  		ext4_orphan_add(handle, inode);
> -
> -	ret2 = ext4_journal_stop(handle);
> +	if (handle)
> +		ret2 = ext4_journal_stop(handle);

What is this??

--D

>  	if (!ret)
>  		ret = ret2;
>  	if (pos + len > inode->i_size) {
> -- 
> 2.43.0
> 
> 

