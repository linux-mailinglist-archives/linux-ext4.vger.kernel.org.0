Return-Path: <linux-ext4+bounces-11902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DBC6B357
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 19:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1B8F724252
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AE3612D4;
	Tue, 18 Nov 2025 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl2f/QQC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DC36C0D8
	for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490564; cv=none; b=deq6sgtkKBtTkfx5rYHfVW8KZ6KE8D57mZBCT4/TUR6qipqGCe278/MgKCJoE/TqDTIUhh01HoGEuk8XHBGZVGxweLpPnBf8UXoN58I7u/sUmVOasrCozLxkC+6PdZFhEr2riwmQ1edR7r9W1Ut4UspiNqTog0+fwAuckNlBh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490564; c=relaxed/simple;
	bh=dy/zvk2wPMn+TK7DuqUZ98vSkYytIzEQ7mNBNI0b9mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HffGcG+iVjrupQ2/A3r7zRZJiBnIH2TIpHw0GAoxmtFcbKDBtZzRdHZCMi4WWWt5YOsKXmOz24y8QFps2eaDCVKZja1QHAxb5UHPW5qlLuzzLrwzZeI+6zauLx+blcPMHLrLY6FXujng6LGyyCDd6STQBNxcWqM+Iz4rUzVtsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl2f/QQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC42C19421;
	Tue, 18 Nov 2025 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763490561;
	bh=dy/zvk2wPMn+TK7DuqUZ98vSkYytIzEQ7mNBNI0b9mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl2f/QQCPeZD493zbZZMwOPtxaAfPlImYv1NdPllSwV+pgkZf2Rusw/9RXRYimmBQ
	 f69AzeL5eNcY0eAC5m/t12txdNyfSq2eD08wk3E7cldFrs0atnh9F9qLyHMsb6P9Ye
	 Y06Z+v+brKKGTvb9FFYcjGZFnfhHtSD+7ONmxJkGjgEUEdmRNvoBC94tHsNmI3q3Ag
	 0GzLNHZ118kFjNiNr+X0AiDuR5boL1tvvejF+0MpQWcbFeIr2StdtjYVDeCKZU0zh1
	 7/1cVcfI9sp6ldYhwkmlU3+peuGvWXvf3nSAk4O8WUElT0eC80yLXyAkz3p+dEk++I
	 6pHLrsBLpTGUg==
Date: Tue, 18 Nov 2025 10:29:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wu Guanghao <wuguanghao3@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	yangyun50@huawei.com
Subject: Re: [PATCH 2/2] resize: fix memory leak when exiting normally
Message-ID: <20251118182919.GP196358@frogsfrogsfrogs>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
 <20251118132601.2756185-3-wuguanghao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118132601.2756185-3-wuguanghao3@huawei.com>

On Tue, Nov 18, 2025 at 09:26:01PM +0800, Wu Guanghao wrote:
> The main() function only releases fs when it exits through the errout or
> success_exit labels. When completes normally, it does not release fs.
> 
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> ---
>  resize/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/resize/main.c b/resize/main.c
> index 08a4bbaf..71711229 100644
> --- a/resize/main.c
> +++ b/resize/main.c
> @@ -702,6 +702,8 @@ int main (int argc, char ** argv)
>  	}
>  	if (fd > 0)
>  		close(fd);
> +
> +	(void) ext2fs_close_free(&fs);

You might want to capture and print an error if one is returned, because
ext2fs_close_free will also flush the new metadata to disk.

--D

>  	remove_error_table(&et_ext2_error_table);
>  	return 0;
>  errout:
> -- 
> 2.27.0
> 
> 

