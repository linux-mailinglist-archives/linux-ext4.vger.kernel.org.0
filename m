Return-Path: <linux-ext4+bounces-5069-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA6F9C5018
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 08:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337D5B2A51A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D420B20B;
	Tue, 12 Nov 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSnTK0kn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9A1A707D
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397901; cv=none; b=sda5gQBpolboWKqF7ZNg4Eac1EuonOraBIF7rczAqEDFHBRu8LkyF9gWT4J/rFHtcIPDEd9Fxapgi/hSdDuGnho4hn6fQKXqUdozNpZEokitPyZMGpZcIfnXjO8LlaS2pvq7BzxBnfrEok7k5VnpiZ2+FSukMHHpwfxEQPY35UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397901; c=relaxed/simple;
	bh=SOQfNorVVsJjHaoJN/Z7WI2R38T4DZZ+AcNlfAuW0w0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TvX/TuU9w5rc2tnstcyO1ocgwVE4EfsUlG88x4BzlQCS6jXV/5tPZbJ1yw8lWIKyy9KcDUgqHOTn+NsUYCJxgz7q0ORoP9NwINssUMOjZge44p2sbjTmDu3Nxzsuvb1y/wRWRKYOx6JCi0EB79DM/UwYs3bZZ+LyKzWCLaG67E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QSnTK0kn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so3641937a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 23:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731397899; x=1732002699; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah9uRvARHaKS0PcNXHxITpGRNkD5oowJ5tevqNEnwd4=;
        b=QSnTK0knwvjlq+qXErmjVxwUYnQ4YtKPxPlJyS0aB1s60yj15lmp16IYy2g0aztW0t
         nqQOVp5OpxsWynYyIzqPUK7Ft+powqHQu7cNLRlTtxDJC2E9RM9Wc7HZfpos9WvHz2IH
         gGS8bH1UWvsePFkYXyA00JkS1HotByKy0sxTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397899; x=1732002699;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ah9uRvARHaKS0PcNXHxITpGRNkD5oowJ5tevqNEnwd4=;
        b=Y75Dy+JY91fonplkgA7DChUxrZAbN3KNuCxje1E2z007tS64maC+x9rHqXVsr9/Eux
         QrdHgHGUBdnaRqFD0EYCJMyY/OnoS/NZYfoUwX8M9JNJDOcnMxSVuWJcdvl3K65ICFgA
         SnPxlBXI4qPkNzoxplXQdPWbrjIWwuzGKAHgEXhGlQdXongSaSTP60mJUAXQi5K0q9fA
         3eFm1L7TCsb+Bd15os6Cj6hcbglh6+pRPcX9lv4amnbFMF4C45u6UaCIvWJ8rxkYCuA4
         272hAt5xuMWMAF7Tfm7oHLGTRdWc2HW9zGt7j5QEg9nA/FjuA2U9wGHwXd+vS2QV9L/X
         sdAw==
X-Gm-Message-State: AOJu0YyCO1pV5dWqCq4CVkOkHtzPh0XuWtpjPohwUdifzODWPXZ/gYEL
	NjrmY9xFw8QTTKqpgbBFXfbWKeXtOaN9LmUf3KhTmDHUp2woh3VUe2ofD9jffg==
X-Google-Smtp-Source: AGHT+IGXpgaPU5/8NvVWcNlzMTiVA+OUBN+eD1IgHOHn5CF/T85iXoWOskWC/tdvy66pZvVrbq1ezw==
X-Received: by 2002:a05:6a21:3988:b0:1d9:1ceb:a4de with SMTP id adf61e73a8af0-1dc22a15e91mr22008600637.27.1731397899425;
        Mon, 11 Nov 2024 23:51:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:9e09:d4e8:509d:405b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1a9fsm9890857a91.37.2024.11.11.23.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:51:39 -0800 (PST)
Date: Tue, 12 Nov 2024 16:51:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: ext4: possible circular locking dependency at
 ext4_xattr_inode_create
Message-ID: <20241112075134.GE1458936@google.com>
Reply-To: 20241112073421.GD1458936@google.com
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A silly typo

[...]
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7647e9f6e190..db3c68fbbadf 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1511,7 +1511,7 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
> 		 */
> 		dquot_free_inode(ea_inode);
> 		dquot_drop(ea_inode);
> -		inode_lock(ea_inode);
> +		inode_lock_nested(inode, I_MUTEX_XATTR);

						^^^ ea_inode, of course.

---

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..db3c68fbbadf 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1511,7 +1511,7 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 		 */
 		dquot_free_inode(ea_inode);
 		dquot_drop(ea_inode);
-		inode_lock(ea_inode);
+		inode_lock_nested(ea_inode, I_MUTEX_XATTR);
 		ea_inode->i_flags |= S_NOQUOTA;
 		inode_unlock(ea_inode);
 	}

