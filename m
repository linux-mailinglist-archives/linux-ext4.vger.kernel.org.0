Return-Path: <linux-ext4+bounces-6420-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2BA3312D
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 22:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0C11883B63
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364941FF5EA;
	Wed, 12 Feb 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="dXkaMLAi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AF20103D
	for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394101; cv=none; b=r4drDJkYq1KKvoq0h3o53idNI9LPZcWZ2yOE5meeFrAErpWHu+m/5hc0l9k5o15C6XYvyvfihRZFmXxhdiFPXlynBrPXd+aq4mk7LGyHrHTogIsSQDL5Yh5avSR7j4YDhPk9Rup52yG605NA2p3PARloNIsXg8e3MkpJW9aARi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394101; c=relaxed/simple;
	bh=1VyAEiQDS2q9VkRGK+qwT+LU5/8emzrXoHFxIXPyBLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II98ZtLDl04lcu77B+TEgc0CjgnxpJLwv7aNw7+nbRipqcxGYek0bsZbfHW8kENHYi446/W7u77RZeodEqg4bFm4SRTPKQcIg3qjX2BvD7RKAMVnLyVbXlx46xtSL2JfaqNEyZgxsOjO/6HIpdxGp8I5f3qDpeVNRbgYah0swY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=dXkaMLAi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f92258aa6so2394105ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2025 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739394099; x=1739998899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIR6zZ2LFfRJBDmVHzXDNp6ZFUCOkYJZeyqW+eFjzG8=;
        b=dXkaMLAiRFcefsSibZnHaWvEIsJnViDbvC4+W3iGzjZxhcLZT4Cxe9mWzWgjiuzIND
         pTpmDbiquuCq58KfFGME0uGDvFmed2973V033u3wJi/ySi37h5jmL1YUM1z5Rr8i04w2
         wplHBC7pIoG0Lk0bMH6HlqJmMRVPjyQ+Hn6+T/BkLm48GEE9nYa5wDRLEahW8H4BqG9s
         ST/IBhVE2F275QdgOJJStNBhB+ZUrtQPxAfv1NvpXyZdO9tiBrScpH9LaCrXO8NL/B6x
         rJV/69IrpGRA/1aduMAnSxhGQ0R4WQ+dASBSFD4HmwSBAUghZmpnOjHUHMfNxEfIt4ME
         os0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739394099; x=1739998899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIR6zZ2LFfRJBDmVHzXDNp6ZFUCOkYJZeyqW+eFjzG8=;
        b=I1gxYnh2VXdWqsIvmuu/YFJwLOgtyLYggsExsHj8EwzY7R+G0hiURCOnFVGTdHxGwM
         d+fm0XI02l6tDAQq/KSW8fG8JStCLHt/i+u5064L2sjHPExgs9U6hEGk39yqMcc7xtrS
         bdjoQJVsgJtOQ90endDeXa2d5FBSKLeX6y6yBsSvmH2rX3zfRFCzwyxIfXP87rTgey1j
         dD+TwALNKiT7uyAPtn7iiGV/eYrXYTO7p205WXCOltwwdTREhNmgvfHel70/BP+qiuf1
         MoFy84UEDDU11rggAUiaA3pqhk+0sz0yMG+KqWON4BTfk9s1XJ7i0Dmir6h3Gdk3wOOW
         /+bw==
X-Forwarded-Encrypted: i=1; AJvYcCXYMCqNXInOQa1ycKQEQKwciLAtUeBt6NX972qwsyWK/PSf/1/50fU7io1IiMqBuLBP9vFtCg1pXS0x@vger.kernel.org
X-Gm-Message-State: AOJu0YwdiTMaaTdtcTx2Qf9PCS/+EzBKjWbkx7I3RKbrr6LJnyqrsLjj
	ZneY/sc0BrP/lsvoqRCLVmZ06fm7O1H/x7MDge4UJQIwOY65fOPkW5ffrZfhAECq4zRhwOIZb2n
	m
X-Gm-Gg: ASbGncuWKFgY/voyYUT67ObpcimUQIk8jIXdOQFL+n6PdJW9F8U8+D74gNZUbWEmYRl
	Tc/WdthkMwqyP40yuD+eaP+uYoTEezm94Mh7dqFo+lkDOsivRvFsDW8srJwtF4/UqQ6zCYRGBdK
	j2ap7IMlpHrsUCdl3flNovme7ahV7BmCaAAfolNwhY3NsyXuOGk6l9lc2iD44F0tdS2roRdowuk
	scFvaCQXb14ouQD+u1Zua6Pcn7zRpAo/nIf/hAt6rdSQBy3GFjveu6UbbxcR4Hj4vQrGS+XaHlp
	CjeZdYqaGNyv+icMXoZ8o8hZhRi/eM6ucG2sDXZg5mqbYlCcduyIH7gZ+LdyRAqo4L8=
X-Google-Smtp-Source: AGHT+IFZQ+UkMOepNiqiOeT5081AklEp/hOZMtQlwn6wyDVLQoiCCEa+ujVvRZhLWXYZgNe74j04vQ==
X-Received: by 2002:a05:6a21:482:b0:1ee:668f:4230 with SMTP id adf61e73a8af0-1ee668f42e9mr5152871637.33.1739394099547;
        Wed, 12 Feb 2025 13:01:39 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad6019204c5sm4418595a12.60.2025.02.12.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:01:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tiJrU-00000000RG6-1CPB;
	Thu, 13 Feb 2025 08:01:36 +1100
Date: Thu, 13 Feb 2025 08:01:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 1/3] xfs/539: Skip noattr2 remount option on v5
 filesystems
Message-ID: <Z60MMI3mbC9ou6rC@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>

On Wed, Feb 12, 2025 at 12:39:56PM +0000, Nirjhar Roy (IBM) wrote:
> This test is to verify that repeated warnings are not printed
> for default options (attr2, noikeep) and warnings are
> printed for non default options (noattr2, ikeep). Remount
> with noattr2 fails on a v5 filesystem, so skip the mount option.

Why do we care if remount succeeds or fails? That's not what the
test is exercising.

i.e. We are testing to see if the appropriate deprecation warning
for a deprecated mount option has been issued or not, and that
should happen regardless of whether the mount option is valid or not
for the given filesysetm format....

Hence I don't see any reason for changing the test to exclude
noattr2 testing on v5 filesystems...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

