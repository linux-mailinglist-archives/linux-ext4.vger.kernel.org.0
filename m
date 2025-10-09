Return-Path: <linux-ext4+bounces-10720-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9871BC875C
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 12:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E331889124
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2082DA75B;
	Thu,  9 Oct 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="U8II0m/C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A32D94A6
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005385; cv=none; b=YbNZDTjy9ek8votW/85WsIlHcLHDUM+cvJa2VECWeLDWNo7g7cfWtiD/Hypy2bEph4ovFpMnPlqpdKCon0LpoMcwF6CC1GgGgTiDpWYgyD8yAeJ0s3CBQHlCgPpUqh9NQUNWdOzYcgI9Z+L3NeFOD2cakxMDrrR7SYwHH69nCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005385; c=relaxed/simple;
	bh=l7QzGI7FmuzLiWBMITL6HLIWO89vnW9gY5iIdUxjrpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=bDuapq0uBCtt0aTE6+gRL5zPcVVzdLngkOP4b/SttBLEyNU0ytPmX7u8YjcCgrj7/iylQMMertHirSIZBfyGMad6dViMS5Jk/J1eIjnuajA9IoxWJNIrV+VDOUUlAZpgFSwVTxSn3hklPDcjAsWAO13MNXeMu4osJjgC53GEM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=U8II0m/C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso5387845e9.3
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760005382; x=1760610182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7QtmyaStV9Cg/SiLzcIFBH2QrCmrrCZZBI5xKAFZzk=;
        b=U8II0m/Cj5yciEwOhl+9+q2n1zL0VJ8txNNESrxpElyWHbpGGnwHprG6I+gMXghbhz
         GWFD+Sn4Fwwd/EzexRWS3+hwlBhwKpwkB7dOqzm+PeouxhNCYAwjjeUUAXsXc0YDeRqZ
         57Xdkk/gqHHmztstOKP+Qx8ypu+0Rr0Gp5W8by86jueg43t9OWW8Xqw7E0ELFFffO/XW
         af4hguikER5MQXTVRKziRjCADGg/ZIFtQd3i3e06rKm7NhumQgmozG96D8lWpKbDmMQw
         v66AL9eg9xh59Ov0hsJExWjrdJ4a7yjES9RPZH0aKyvMu+hXdWsPrURGNh8vI53ayfn+
         kHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005382; x=1760610182;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7QtmyaStV9Cg/SiLzcIFBH2QrCmrrCZZBI5xKAFZzk=;
        b=gxDcJkdB6EYYqNBCCo4JAS3NNr9GXfOYuHwikigJk//CEwPv5N5K/o8kx8VmUJ/S7r
         Jby51LblwnLDqBJykgTUkaIaN82VUljrQcNEwG7+griJOPbGAToj61Pj116lgkIfHRNw
         Cq4sDDoRcqOs4i2R1vEbBl7MOdcM96zpgDG3L0rTYxUHkEwBO/9sdO8iJr1ElRGsNFAu
         25F3BPRc8YM8JunpePhn/MGuQG+xII2ZhWClWs+BomFXOHRJ9fQ607pfBtpV3IXZF9bf
         Rvvzq78wtyDIylhZfXzbB1cohrcSL5CIdSsfFjr0b8vqd0azldfg0c9fOct8JQHwXoAI
         L8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvnrMnEqOdQheACKfcFDRmn3I9JF83iBLooyNncuN6vZm/PqdOpi2/yjT1wxY1nFUYsqyyYX9xDIht@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKGp4oS9rfnY84IV81rGqnQFa1XrBU+QKvuPFflX7LAJWOOUW
	UN/ZYkis2xQoUJnxm81m/PoiGljJkT1vBCrbPumF4YI/5e432qiqBVUx4MgKLDfR9fc=
X-Gm-Gg: ASbGnct0kTs0yl/SrToCAOfAA61JrJlwKtMhvlbbCfU5M8ImXM8n3OPXxlvfyMKDSgx
	gL6P27T1OiLXUKBe+s2iMwQeEgqJR9ffJvi6R+3Nmw3PJGlr5hdfH7DH72Y6EuRbgT1HUgwKyTM
	zIZNW/03ESQeSv7yxVdjRirBGxijpwLzDGy2BuuAN4V2zOG8I+GF/t725Ej8lYIjw/cstRwTNs9
	jN9F+dZawYMgRKCetzcKZAju61dNEL0SFWc3YX6G8gQIpv4OhLAgPaTtDUFYVvVAJ8AdK7M7wAq
	H9Uj6hGX3JWTAMiG++lqWLTP26YKgaFUMKhT8AgJu7vJSCsBTckcxrHCr0t71D36p3WGxBqyUla
	SUD71a2BevK9f9ZdPeNL4rIttXXr7Hh/JvxlXfbzoBUpN+hZuPvE0RcdoXw==
X-Google-Smtp-Source: AGHT+IEStIkragv6qCXCo8V3gHP7SZNoyJGu9SkTjAiRd/XZfLMJTPJ93VfbPipyaCKgSacW7ychVQ==
X-Received: by 2002:a05:600c:528b:b0:46e:6042:4667 with SMTP id 5b1f17b1804b1-46fa9b11b24mr49480295e9.33.1760005381887;
        Thu, 09 Oct 2025 03:23:01 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm33204695e9.5.2025.10.09.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:23:01 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	kernel-team@cloudflare.com,
	libaokun1@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Date: Thu,  9 Oct 2025 11:22:59 +0100
Message-Id: <20251009102259.529708-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008162655.GB502448@mit.edu>
References: <20251006115615.2289526-1-matt@readmodwrite.com> <20251008150705.4090434-1-matt@readmodwrite.com> <20251008162655.GB502448@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 08, 2025 at 12:26:55PM -0400, Theodore Ts'o wrote:
> On Wed, Oct 08, 2025 at 04:07:05PM +0100, Matt Fleming wrote:
> > > 
> > > These machines are striped and are using noatime:
> > > 
> > > $ grep ext4 /proc/mounts
> > > /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> > > 
> > > Is there some tunable or configuration option that I'm missing that
> > > could help here to avoid wasting time in
> > > ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> > > fail an order 9 allocation anyway?
> 
> Can you try disabling stripe parameter?  If you are willing to try the
> latest mainline kernel, there are some changes that *might* make a
> different, but RAID stripe alignment has been causing problems.

Thanks Ted. I'm going to try disabling the stripe parameter now. I'll report
back shortly.

