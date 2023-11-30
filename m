Return-Path: <linux-ext4+bounces-237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221F7FED78
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 12:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A8E1C20E3B
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 11:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966303C091;
	Thu, 30 Nov 2023 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h79ZMiAB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320CC10D0
	for <linux-ext4@vger.kernel.org>; Thu, 30 Nov 2023 03:02:15 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce322b62aeso448095a34.3
        for <linux-ext4@vger.kernel.org>; Thu, 30 Nov 2023 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701342134; x=1701946934; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XlHKvTfjNrxrUOarndbkj+tn5R+dTKhE025RkL9zzGg=;
        b=h79ZMiABaLmUU2Ux4c29/XLqLfesMSMQNSYqiArSWRLb7B943C3z+hP+F6f+dlzrWs
         ftBTtlE7W/bg1km8NsZRMfRtHGcR+w1alhLwiaX4JPbTTHvOwlsC2VgDSQFD7D1saEfb
         d2xNuKrq+VlOml/BAutHP76+G5RGD18R3dpf5nJiLeDLOkRJiKsQj5K/778FFcNBEAgy
         nqlVLBq6rmnOxI9F8Ee6k+Tt8+RVv9EYo1u/ai3YtJXU7TzjvL40x5BPBtBqN/JVU8Wt
         ZKxLqNsoI1cRjxHI4wsmLXWqhyoEPIQRbSNgy95yjZaZw2CiFX7hEmTLUP5sTQNBYHf5
         on8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701342134; x=1701946934;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlHKvTfjNrxrUOarndbkj+tn5R+dTKhE025RkL9zzGg=;
        b=j3sKHpZUgN9rIWclbbWNT4C8j3ZvacsGbPNgVthFQ3XmmVDaInUuYx6duu6zFQjFUM
         5H7dEkBu8L7fpeF5GKS3zdew8m7m0FUqCL3+pbEcf2Jwq0aRUtYETdKMzx4sed6loJ2V
         xWt70stFo8t0mTi6+Rp1KufqsohIjn0H0qmtBC7LN8BphEBNedtTu0Lbj7K3Ji5+m2A2
         FU1y0SwlwrVDC8nHz8XGxmaNfD1KDh1G01+g7T1cr52wlU56NRtQs9/eAGklrpJ52yU/
         ipRQYKa8ADQOV3rM+aMK8MDo0Ag/384tp2Ltssz8I4G8Qjk1Uz0XnIw3s+F2beDK7P96
         wW4A==
X-Gm-Message-State: AOJu0YxsbyeDaxL4nqj2IX5ne05Az9Xh7cMPQgZzZ6o72C+3EYKCxCrA
	dTrk/O5tV9bm0xpUGx4s4/gr3s/Xxrw=
X-Google-Smtp-Source: AGHT+IGXnQUDymspxeR+B/ZzKAOFp2id/sHHUsfuMf61v1Cr2ex4FJ1XUdX5AByd0Tr2BrXHHWWH+A==
X-Received: by 2002:a05:6830:6c18:b0:6d8:119d:a0a8 with SMTP id ds24-20020a0568306c1800b006d8119da0a8mr24117578otb.13.1701342134426;
        Thu, 30 Nov 2023 03:02:14 -0800 (PST)
Received: from dw-tp ([2401:4900:1cc4:6c8b:6e63:fbc7:5622:17cb])
        by smtp.gmail.com with ESMTPSA id n9-20020a634d49000000b0058a9621f583sm972086pgl.44.2023.11.30.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:02:13 -0800 (PST)
Date: Thu, 30 Nov 2023 16:32:10 +0530
Message-Id: <87bkbbijwt.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: Fix warning in ext4_dio_write_end_io()
In-Reply-To: <20231130095653.22679-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> The syzbot has reported that it can hit the warning in
> ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
> reproducer creates a race between DIO IO completion and truncate
> expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
> inode state where i_disksize is already updated but i_size is not
> updated yet. Since we are careful when setting up DIO write and consider
> it extending (and thus performing the IO synchronously with i_rwsem held
> exclusively) whenever it goes past either of i_size or i_disksize, we
> can use the same test during IO completion without risking entering
> ext4_handle_inode_extension() without i_rwsem held. This way we make it
> obvious both i_size and i_disksize are large enough when we report DIO
> completion without relying on unreliable WARN_ON.
>
> Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
> Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Changes since v1:
> * Expanded comment in ext4_inode_extension_cleanup()


Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

