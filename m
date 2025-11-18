Return-Path: <linux-ext4+bounces-11901-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF91C6AF90
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DE0092CE81
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233633C1BD;
	Tue, 18 Nov 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLoGzHJf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC482877F4
	for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487078; cv=none; b=dfjl2bsrjfp4iUvzv+joFqpmly3aAde0wy372aKwGGuYGOMDYKyA5lHBtkwiMvFiLah8EH9Hk3yQi0pgV3PtjJuejpJbyo/yDXYkborH7zMcAJkZMCPeXa92Tnq3kIn+UxlBbkVMnHTWZNgIQqfnK3YSaYm49drfca51K8ycEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487078; c=relaxed/simple;
	bh=nhASVdDt4OdAwVAANU2bomnv6+IJT33HttvU1MpH8Lo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=VKSZuMRN4Kq6nk5S30NdnjKoQCZ0FyXiwFSXwdp6rE1A8xahpmghzq37/22GpDEEIG4z6rCUijr8bNO2UAZp7pTzVUy6K6jdB361JJcUGtvNB6PCqG97bEGBVg72ohSe/PYQztM4655KejwIboc882IOAyj90dgd7Xd8TLk6JZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLoGzHJf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so4661384b3a.3
        for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763487076; x=1764091876; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=NLoGzHJfgXsbAIpeLOuT6H6thcbOWsDrkYUlxHE9fk3EaW4cGSmISVyDK/gU6ynD88
         N14Z9t/iBYvcVGGUJmeap1tNlmbkLAjhKlO+R0Dgqq2Is/zEvq+xKgVPOz5ZG5yPGTNM
         ubaLmhdYov6TNgBBIgKY995lAQtqIcbwfnFAi76HWg7vURciDFf/clqnmsX/E6xwn9ys
         HhzeJjSb/w6tbMbCjRS5qTE6A3g4D5uSTi50vWEpjslAIkTDywlrFQRmUKQfGoaiFbgV
         Yoju0NimoDihKurn/a1/7eNFWW7gMu4HWdBJazse1O9QWcZTXqRrQHyNqfB+W5W3kNjs
         8KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487076; x=1764091876;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=HrxBJYdVT/ftI32YMkTCfGC4J/+6XMlgiDsQjb2fMtn99Da5JrGA1mFDR4WovN8Fer
         l2zQrxm27MtLq0ewYScisbKMA7aw7tEr+oYTj4CH1RuoQUBn9dElNH0TzynOQkxMC0RP
         /GLSijB+ZkvifiHLf8mblH+Vwv0hWnAo/g04M5I3x4Rn0AyVyxrLM15YGNfYhlVp1TwI
         aY6vPBFYwp2jbG1mAMEAtbFFTrrqszSqhfMfPCm5ILvaKs2YFIbM2q4XC93gx6/fGJhq
         lMt/r7BKuudcUTo1JnVSkNK/iUYXsXA3D18IJTljmcUDgQH2S0DnUQX6aUqyxLa166Zo
         IOvA==
X-Forwarded-Encrypted: i=1; AJvYcCUcpxdZWFI9/vmGzuBrnzl7ECVNsHTVqlngBakoaW5u0r46lcXmXFnoRNEx1aFMALoEuLbFUmItl+rN@vger.kernel.org
X-Gm-Message-State: AOJu0YypeJQFrIDqUlCNzL1yzssoY32dOFuJd/bOkID75/LQU/CiRoih
	cn2BvG03XabRsoVM3MZ8MEEVUK7K12YT0/CfwDYmWiwYJkPPg3VOdJfh
X-Gm-Gg: ASbGncuwOX5/PIy7JsKMgFRF5H9y3qI1oRYxlmCx16o13LVY5MPYbCEtTnX8ya6aAYo
	fhHRBSs5MvTP7ypYsB94s+upTGJroPfd/eLl23Ls+PLq/deYVNWDmmrMll47hZOvpy01izix4BI
	4AfmvrKOxNsXTYQg1RE0uK3xI1SWjvjvZkgfQW4IjFENDImyhDHNx6fmoNifO9rbfbx7O7ZJHP6
	93uN78pXVUDyZyyFKoRggtXvpH47FOaAKou5qnjQcKVULDAuxijkI+TtZEEmlWr1wMnOnPnGmT4
	bgZTrzaCrPdEUePNGo/ddgTTHGBp0Glwde+naI+xY82M7+BKH+hgpytbVDHQJlqUVOFf0jPHmEA
	tM7xlQ8A9sY3QljXpkVy5lsM+yCdxyBCqnZ25tdVwu50e7J8Ssq2TV85WiOiaj/+TR83cjcw=
X-Google-Smtp-Source: AGHT+IEQrU5uwPDP3B0D60MQHHmGXSAeXE5fv7FgIePf1xPikPaNbxxiXR2fp/Zl+qVssNoTrpyjFQ==
X-Received: by 2002:a17:90b:3843:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-343fa751ad3mr18844371a91.37.1763487075532;
        Tue, 18 Nov 2025 09:31:15 -0800 (PST)
Received: from dw-tp ([49.207.232.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm1694884a91.0.2025.11.18.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:31:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
In-Reply-To: <aRcrwgxV6cBu2_RH@casper.infradead.org>
Date: Tue, 18 Nov 2025 21:47:42 +0530
Message-ID: <878qg32u3d.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com> <aRSuH82gM-8BzPCU@casper.infradead.org> <87ecq18azq.ritesh.list@gmail.com> <aRcrwgxV6cBu2_RH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Nov 14, 2025 at 10:30:09AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> >> From: John Garry <john.g.garry@oracle.com>
>> >> 
>> >> Add page flag PG_atomic, meaning that a folio needs to be written back
>> >> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> >> in upcoming patches.
>> >
>> > Page flags are a precious resource.  I'm not thrilled about allocating one
>> > to this rather niche usecase.  Wouldn't this be more aptly a flag on the
>> > address_space rather than the folio?  ie if we're doing this kind of write
>> > to a file, aren't most/all of the writes to the file going to be atomic?
>> 
>> As of today the atomic writes functionality works on the per-write
>> basis (given it's a per-write characteristic). 
>> 
>> So, we can have two types of dirty folios sitting in the page cache of
>> an inode. Ones which were done using atomic buffered I/O flag
>> (RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
>> need of a folio flag to distinguish between the two writes.
>
> I know, but is this useful?  AFAIK, the files where Postgres wants to
> use this functionality are the log files, and all writes to the log
> files will want to use the atomic functionality.  What's the usecase
> for "I want to mix atomic and non-atomic buffered writes to this file"?

Actually this goes back to the design of how we added support of atomic
writes during DIO. So during the initial design phase we decided that
this need not be a per-inode attribute or an open flag, but this is a
per write I/O characteristic.

So as per the current design, we don't have any open flag or a
persistent inode attribute which says kernel should permit _only_ atomic
writes I/O to this file. Instead what we support today is DIO atomic
writes using RWF_ATOMIC flag in pwritev2 syscall.

Having said that there can be several policy decision that could still be
discussed e.g. make sure any previous dirty data is flushed to disk when a
buffered atomic write request is made to an inode. 
Maybe that would allow us to just keep a flag at the address space level
because we would never have a mix of atomic and non-atomic page cache
pages.

IMO, I agree that folio flag is a scarce resource, but I guess the
initial goal of this patch series is mainly to discuss the initial
design of the core feature i.e. how buffered atomic writes should look
in Linux kernel. I agree and point taken that we should be careful with
using folio flags, but let's see how the design shapes up maybe? - that
will help us understand whether a folio flag is really required or maybe
an address space flag would do. 

-ritesh

