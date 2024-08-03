Return-Path: <linux-ext4+bounces-3623-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720D946691
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 02:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA53282F4B
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 00:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574554C98;
	Sat,  3 Aug 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyvbfGHs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752382C9D;
	Sat,  3 Aug 2024 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722646279; cv=none; b=jeEd0FLSGRnT5d6pgYeeI6ROf47QJbxyWCXXDWVTkgittpeTAG6PrFSGedxYAC1UX/0BmXA/4GiTXaGLc2UBldqnQ+W8H3M+uXaoATy3Bvzg7mIPuxfQKvwwZwtd7ZzQFj8dfJQywo7mTLIxW7ta7TxKl7QztiVyJzhWoPx3D5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722646279; c=relaxed/simple;
	bh=RTkxc6I84bdvVPb8GoxG2LV3JLBwNLUiBmnEz8xtXFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwhb+G/GS3jktSEoQtBczTGtQ3T8Kqr3Wfbdvm9EVfwvBypwp5ZNr7NGYcp4rIUGg2Orv8+X5jD6Tta/7UWT8M8/evcbyggCQT2TqlgccJu/bKloJrikWbIJqB/zh0CJqrmrl8sU3G3dwJpA7RjZ+gCeEOBSoqxqUkjCzmsUSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyvbfGHs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso7295913276.0;
        Fri, 02 Aug 2024 17:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722646277; x=1723251077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF6lPBu+GXJKCl6fvSnUfVPaRFPsPcznlQW/cUWRjlI=;
        b=WyvbfGHsgl6+3TVVkjO81wT9eJQWsJd8IYGCN16FnMDL8SwvuboxytMRnHBPpdFwoa
         PESIuFHIHqAfH2nxf88C025Z6shmThmDJu4lkyM7DjSRX3ipnVnWw1ZAIW3vyedpVY5Y
         7NhY1TVf5Ik2maZ89WJTdlHt6Aul7w4iymimkdhWder1Houc9JXuUq5OJFXWFkWFzxms
         q2/eWDlVQ0axdVtYVkhTDg2l8AWqFIWwbde8ZDnUPzgsZTu2YjQGcHClgHNT4IhSrRyU
         4LOmUZFH/rzEuWbXjr8MxL+wcx1QINu+sbfvfRQoAKKL+4OXYtRwPvCd7Ba0TJ0Nh0br
         rFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722646277; x=1723251077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF6lPBu+GXJKCl6fvSnUfVPaRFPsPcznlQW/cUWRjlI=;
        b=rLbZV4tYy5R4SjNFUDMlFo7vzZiPNa/QChkKuWT9/JC1zvN9nYuF5836lrQBxZBA7G
         7UZkOMtc6oJiDpcZ3xUjJIsiwGH3DwsRkx7pmLWlM0U1dOu8+1HxcT7d4j8G10nK5BPv
         gxj97ty0q1N8p1C0ht7ajxUK+Ui7uI29VYmR8+NELhB8MI7LL8gmzm/2oNj0OMRHNfqk
         PiBiA0BDeID1wz8opFaaAtaX8Yjts4ysXifn5K8HLm3ylYqJiLHU9JkxADh8ZapQUTpE
         Hu5sbWKJFce6U04mesOZ/l9SChswWSTnbqeV9R3A4Ze8ZYQVqUQAAqCa5Vw1Z0/QFGTg
         siLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzxyrqEYiwDrcaF9dMjC3JfuofOkuAJ3N5HQyPT3qDqQDq3oRDAPKDUTnOD0Khzl2fOwS8IHDcUYoC@vger.kernel.org, AJvYcCWi1RipZJJ5nZRbrOv3f6ge9ag7hCwQrkH096wUFpbU6Xnwx7Yqk/GSHMRSkeObEhiHJVpQEGjW@vger.kernel.org
X-Gm-Message-State: AOJu0YziNuO9hYm7yPen7fXNj3W5dA92tHoRkqq5XoYOQ+aXDe9WX+0O
	eXIQdtwcg9of6NGyCv1L8vXJgt3mmtaVjBFslwkNK9OfQaoERy5xGcSlew==
X-Google-Smtp-Source: AGHT+IEBTsk5V/+YRzCXjfl8kEnMhrSyiHizEydnoDadPBo+Z5UddHW2msQt0+QfJexIPaxIRc5Hug==
X-Received: by 2002:a05:6902:2605:b0:e0b:c94f:3040 with SMTP id 3f1490d57ef6-e0bde2f1ac9mr6408100276.27.1722646277292;
        Fri, 02 Aug 2024 17:51:17 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4519353cb62sm5818121cf.29.2024.08.02.17.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:51:16 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9F5DF120006E;
	Fri,  2 Aug 2024 20:41:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Aug 2024 20:41:42 -0400
X-ME-Sender: <xms:xnytZp52NZt29jyj0xGj5IbTb_f6XrFQpG_O8PHX7-icOp40OFmSuQ>
    <xme:xnytZm6R88PfEYALKYgi3prhLO5tWHte0fcIJ2AaJncI7QWxwy28n4pxsmw0GrlRI
    wpBkIPftghKXMbNnA>
X-ME-Received: <xmr:xnytZgcYJrD4Gt2ybc0P85ZHMGkEfj3sAI8enALR9-JPJxATxjSKXZDN3TJE2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:xnytZiLxJbfj01Q1XVh3rDYdIVyDkZT6rJ_AhkAVc1dV-n-ruVJ1Cw>
    <xmx:xnytZtL7ZxWE-hhLpd5TZ-96JsXlb5i9OTYq1-4DtuB4gy_TTHa3hQ>
    <xmx:xnytZryAA0wI9kGfQTgQA2DP3irLmn4o7Xpn7v0OMRweIZ5zCnwJ7g>
    <xmx:xnytZpJJFKupnBa-qMnvwhyCGWzoi4vVFjXdk2auOhCEiOAi6QArZw>
    <xmx:xnytZgZMBYlBWkPDFirQLGbLVyxqlCoy-C3JDgEshvWh8T8GaLI9WWXh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 20:41:42 -0400 (EDT)
Date: Fri, 2 Aug 2024 17:40:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: botta633 <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-ext4@vger.kernel.org,
	syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] locking/lockdep: Forcing subclasses to have same
 name pointer as their parent class
Message-ID: <Zq18kvtkjD0R4lGX@boqun-archlinux>
References: <20240715132638.3141-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715132638.3141-1-bottaawesome633@gmail.com>

On Mon, Jul 15, 2024 at 04:26:37PM +0300, botta633 wrote:
> From: Ahmed Ehab <bottaawesome633@gmail.com>
> 
> Preventing lockdep_set_subclass from creating a new instance of the
> string literal. Hence, we will always have the same class->name among
> parent and subclasses. This prevents kernel panics when looking up a
> lock class while comparing class locks and class names.
> 
> Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>

This looks good to me.

Regards,
Boqun

> ---
> v3->v4:
>     - Fixed subject line truncation.
> 
>  include/linux/lockdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 08b0d1d9d78b..df8fa5929de7 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -173,7 +173,7 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
>  			      (lock)->dep_map.lock_type)
>  
>  #define lockdep_set_subclass(lock, sub)					\
> -	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
> +	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
>  			      (lock)->dep_map.wait_type_inner,		\
>  			      (lock)->dep_map.wait_type_outer,		\
>  			      (lock)->dep_map.lock_type)
> -- 
> 2.45.2

