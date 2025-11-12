Return-Path: <linux-ext4+bounces-11840-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22FC54AA4
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 22:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61118343914
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84C2E5B0D;
	Wed, 12 Nov 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YTZQqEPi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB122E62D9
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984622; cv=none; b=ec6VcnkXGTyArNb3b4bzIZj7hf4JPse3Bxw8h66gPEd9Nv2kogORkZkG6v/MCGrlbLQw7pZlxmoWYlwkJtgCGqjjPY0UrUIKmPKBAfbm4OZlg6H02oKnEa+2MocnLvS2lOC42zolRK9oJDOWIVAIYbxsZj5TS+KgfzeHLvbkGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984622; c=relaxed/simple;
	bh=0OTFUF8dKlxaDdn36rkr2KB5xF/wOSqhfWxtBGzWaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7CTnlVcl6n19Dew4R8UD3ekBrikpldhUC7ii7QHfUWLLbLvSCScnKre8XbPuUg+Nr4RpJV4jeqJjdRRsRywT0VAlWkbzaYcY9sXmEijxxmfEtx3sgN0BH1JGUyF8Caw2Uf+kSBHSUcqx6yVCL3iO4eA/ga//6BIP85MV+IUOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YTZQqEPi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bb7799edea8so94742a12.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762984620; x=1763589420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=YTZQqEPiaS/si8bOxnMCFdjnMaTXToGa+627P0ihXde9THCYTRabrnR046dIV/9vpK
         /xGW+/fpk3Ayxcxslmwu8IskYnDVZNHuoz9XgU1oKhwcgEecoUEg0CDvUWsiwQ9QhrD6
         qLzuJ3lhLMCeBg24li73qvZf9qJVTZEH6YQ5QfO7ag9GmeW0S553HICngVx2EtmTy1Zd
         W1TXGld4qghxcGaaLTfm/yqBFdwe9/CMI34rzzA0dL6ygouoq7/eAotojbh3vs493UHc
         P/Yptk1U+JYikQORa3NX0S9xOGe2j4bmELyr8Eqj4URJvRyHBtGASEtlIQxNcDPAl4zc
         Shgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984620; x=1763589420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=g6RRyLouI0I8bfBMHiO/8f/MyMgkIj+rP1hJ9D2W8jpXneJmqOnEHXceE7l/2Xjp56
         vC/bb+kteyIEpMA8Y9uDOyoGOW/O1ph/cPg7c69qzMOAo3LEp8paikjvIEdoa7JRelzE
         5KRWxClMVI58DU03mxnjOivllOK6crTkqLHew6b/QOU1H2SzfCx+vCu2jOwOBfW4TDI/
         wOi32hiAymZORJwX3WiVuI0G4Yxqo/inaPpsH8AjYwGRzZsuAwNZsIcFJ4pfnzO2cD35
         lxppV2YKnXxjyc08gy/hxPIsOGyRSpf3C3B2/Zg2W3TKUeAJuy+pzGFy++UR/jFsGw6W
         hlnA==
X-Forwarded-Encrypted: i=1; AJvYcCWqlrvQqqaZHsEliVdLNxokfu+SUIGajECSAFUIRkbir1IofAPX1a1MauBvftXoAC/xSmO5T9zGcr0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyLJT8XdXAcIV3k96g80iI97LDhD9Zr0e4csxc3VTf7VF2f1h
	KrWLLWbk2LQ6l8/yNJxNFtf8jtCt5rp8qEmU/LUfDBTUBWOQL6q6F4Tyg0gmkN7+8XM=
X-Gm-Gg: ASbGnct8hW04Oa2cIZEPiv6GVIt3VwPqeFFNMEAjCykAZpAIAGFItuePQgSm6t346SE
	jlWHW50YImim9nzebfQBvgAKn1kv3sWQ/rIfSmjZ6ChF29whYIK5nPon2OqtP3lLF6qQ5MbzK1n
	f7ztUx5eTU511Hicy6YrI6ptYwDNujsfz1InDbjrVkNG6Nok0mQHY5kq3PAs4tXjBKc6wqOYks5
	7Ll0DSpRWQpPDkkd1du8iuJBxhQr5fyW2CcXZFbj+BJBj4o4kr0bV5pzMwT1xDx054YHxFfSvf1
	bIl85nEsV2rSr7ueZz8LPIj1Jr85HDSWJpptVhnQCRaxUxqENnsz6n4kZCc3aNe4JhSRW2iHbaK
	hTrw/OODEJ/fGMJRNnChKwHtSBnODDVFIBgVzAOKINWBh8K4xBbAwQPMXJ7XM+XM+zefKs4Tca5
	XkWLWRo0W9cysbsnU4U3cAtEnPB8ls9B1salUXG4gAv9BtTe8U6A4=
X-Google-Smtp-Source: AGHT+IGGcSgtma54hv+7RKzmUmjycRVqw/LnJDNDCrdXo50noFmBCjb2IbQqtC0Ft6zra7BT9FpOHw==
X-Received: by 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr56523225ad.33.1762984620190;
        Wed, 12 Nov 2025 13:57:00 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccd1fsm1507945ad.110.2025.11.12.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:56:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJIpk-00000009zCe-0KVQ;
	Thu, 13 Nov 2025 08:56:56 +1100
Date: Thu, 13 Nov 2025 08:56:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
	willy@infradead.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRUCqA_UpRftbgce@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> This patch adds support to perform single block RWF_ATOMIC writes for
> iomap xfs buffered IO. This builds upon the inital RFC shared by John
> Garry last year [1]. Most of the details are present in the respective 
> commit messages but I'd mention some of the design points below:

What is the use case for this functionality? i.e. what is the
reason for adding all this complexity?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

