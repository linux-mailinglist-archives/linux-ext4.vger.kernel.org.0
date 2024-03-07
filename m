Return-Path: <linux-ext4+bounces-1559-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E035874AC4
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Mar 2024 10:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1701F278EB
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Mar 2024 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF0839E8;
	Thu,  7 Mar 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfZqPwJ0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9293823BF
	for <linux-ext4@vger.kernel.org>; Thu,  7 Mar 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803423; cv=none; b=MTkqLtk3v/NjWreGrXr8z4OclAdlb/28pXj4qk9kKhHedxdBx4kL5F1qhabTKselDJGCVX5M+zbIBmgWHC4bax7AJ7Sd5Jb+djVLeucvRdnnu+cc3U1CVKynn3I6EEspCkRJmusAiN+Uyu+mikQVys7nyibMRPOD1AEo2ZTNg60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803423; c=relaxed/simple;
	bh=Z+qnuzH0SADNVLRX56gB3CZ0tgp+E9C4FDDx9MJoLQc=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=NL4hTtW/0VGVD94x+9teWLp2UJTdy9elwKlydssM7IRJFstqPksTu9TBCnBrTgd4OUd9/70WVTp5mc/tfUqlp/RHYVcHGQEEa6RNOcp5LeRHmGZ/iteT3xjZ+higQlrwnTM7r3F7rabF1vVUXG50yjE6PujE1vv+3RunG9djQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfZqPwJ0; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1ea5e54d3so285952b6e.0
        for <linux-ext4@vger.kernel.org>; Thu, 07 Mar 2024 01:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803421; x=1710408221; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YDrvKarOv8BzDV7KIs62jrBUm425uvFmhj61lJDwmWM=;
        b=ZfZqPwJ0fF/L1dEzoypUWhKGKMShJP6miKZhW4Womdp0g/RFnsbgiomi6r2gMmNbW6
         zg+JmUUqotyc7D0fVDZBBffRkQLJlEANg+1eAMNJ9Zug7veLG/phULu/BTJtl9MlmsxB
         AEiM3YDOn1Av4DOd1Gf2D2ykpPvAaxoFs4g+ROl85lcQOIan7xTYxOLfRqmdGBF/lz0k
         ADLIw6aY3PG3HXGMjEUj86Jb0lWRYpygsU/zVnd4iT/DswSs4FRdna0ogYiAX1xv0e9N
         gWUIZ0SWANt3dI2eD76KcFUE1792Dyi5FO4Zzc50hM4RF03ADAM6zrasNHRAKf4yGKmI
         Lryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803421; x=1710408221;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDrvKarOv8BzDV7KIs62jrBUm425uvFmhj61lJDwmWM=;
        b=ntBIlU1Dfc643FwC8NZHgAPxa7Gnh7PBhFbxou5R+3wLnPU1LviRCfiVK7/cZOd0pT
         fO0WLpqNAtZvD+zZLCe+QjEohTlJVMFhNcehgFoJ+V3l0C1pBG3I0Mp18RREre35rLkr
         tVKUBS8GvANUzHlMTcaJug5ia5ID//TYxCc5dxtjs4gvJ+7c+VklYYMHaw4iEwM35uCM
         cistbzZtXDprriJTPSbmkRiW1p6Wp8VqzRjlzMZavAPpMZ7kBTbNrJOnF2qVl0PGAjx1
         InPrnGmosGL0nUXz+mgFqOv9OwIoxriWCJDNHqAuqEmHMJ8nSQC6mErqiYgHJuowfHm6
         CgZA==
X-Forwarded-Encrypted: i=1; AJvYcCVK/O3f9iNOwUgQZI4XUeC35Lk2XOc3h0I9mCI3mdyAUCMHYMxKcN5m8e4b0JQ3ywZrTZseX1OJlF1f/EqB8ru8EJ8GmWNpO8hHwg==
X-Gm-Message-State: AOJu0Yz0E0GG35ofx2eApVw/lqfwTB2/Y5iQchwketkzNPN5sLvZf9rb
	LQy1CWqQKRt7ugwos77K0wslo3lO+RXsRIH+XotZkaysj+gcqfHD
X-Google-Smtp-Source: AGHT+IGtJRTFjbMqkS9OwU8oYWIZ79FUya4WqI24uWFodXP0JCnrBbpVIP6qYSanUhbWA8J+rWhgJA==
X-Received: by 2002:a05:6808:90c:b0:3c1:eb8c:ca42 with SMTP id w12-20020a056808090c00b003c1eb8cca42mr6891917oih.47.1709803420698;
        Thu, 07 Mar 2024 01:23:40 -0800 (PST)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a000bd700b006e04553a4c5sm12152450pfu.52.2024.03.07.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:23:39 -0800 (PST)
Date: Thu, 07 Mar 2024 14:53:36 +0530
Message-Id: <87edcmpf8n.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH v2] ext4: Enable meta_bg only when new desc blocks are needed
In-Reply-To: <20240306073923.333086-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Srivathsa Dara <srivathsa.d.dara@oracle.com> writes:

> This patch addresses an issue observed when resize_inode is disabled
> and an online extension of a filesysyem is performed. When a filesystem
> is expanded to a size that does not require a addition of a new
> descriptor block, the meta_bg feature is being enabled even though no
> part of the filesystem uses this layout.
>
> This patch ensures that the meta_bg feature is only enabled if
> any of the added block groups utilize meta_bg layout.
>

Makes sense to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>  fs/ext4/resize.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 928700d57eb6..b46a1c492c3f 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1996,7 +1996,8 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>  		}
>  	}
>  
> -	if ((!resize_inode && !meta_bg) || n_blocks_count == o_blocks_count) {
> +	if ((!resize_inode && !meta_bg && n_desc_blocks > o_desc_blocks) || 
> +			n_blocks_count == o_blocks_count) {
>  		err = ext4_convert_meta_bg(sb, resize_inode);
>  		if (err)
>  			goto out;
> -- 
> 2.39.3

