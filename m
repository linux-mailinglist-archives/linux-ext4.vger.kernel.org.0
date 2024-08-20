Return-Path: <linux-ext4+bounces-3807-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3A958F6C
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F34A1C21D95
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636651C5784;
	Tue, 20 Aug 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLES6PMI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B049626;
	Tue, 20 Aug 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188034; cv=none; b=CUSy/5cbmGYjpz2AMTiseORQBYnYDxiIXJQ+npD4HBnz/AbSW2SppNTAx2jS5d/kjvm05imVrx14P+AZXrQqungbebQW9O/lmWaPBYM7PCHK1rrki5Wx7c75Esvd3Kdwas0/Th51LC2CNVBi92P+7r2j/X5sPgd7im9uG/CHeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188034; c=relaxed/simple;
	bh=fQhZtC5XTX1rDuiFtWrrHer8RBBsdR4bJOjfqxeR3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB/dF/fuQz2XaquCMhxsy46Orw/dicl1vrM41Gv8EMqaUfSEEqDazgJN95EX2PnjKUxF0jpYEhzk1PqVNC5cR36j+yzcxPbbiUES8r9rXF+tgIqeWNCsb7+385vPhxJoClOLDSYevDoDm/jPpaWnjh9t4Rc98DKIQZRVbpBsUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLES6PMI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a501dd544eso363506085a.2;
        Tue, 20 Aug 2024 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724188031; x=1724792831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeUcR+7x0h8eh8YMQcLoUHiSpTodLwBICD59aETT1fA=;
        b=CLES6PMIDzqnC2H1E8gWaqFjQXBXTZSLKcBM2FQ35D+mVNzfY5YXIfT/4acgE31G8W
         raUn6N9OgOEFIsi+lkPa/rLlwR1iLCn7TBimnnVnZmsmCS+MITqcWPKv2doibEHDiS4m
         /fOI/USpz/HnFmRDZyeXal9oeV0rA1++DUGpPqZGSe7BVYnQE7bYZXf6yOBS41Irtc/V
         rQ4SlOQgLsw1rDfo2EETc8DOXLMl4oAGWHngop30ZeoBz5Kf6G8niwVo8VDikCAN7xhU
         vfvKqi0V2ofZtXAJKyOu2VPc2ZzN60Et3DGncFOOIk+k1hYb+RTIDaGvA2GUMJeEbnZU
         s/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188031; x=1724792831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeUcR+7x0h8eh8YMQcLoUHiSpTodLwBICD59aETT1fA=;
        b=RlWUWnWbwBjLMm/roDof9X7M0Edm78Zj/i6tTcNHKNAPsDrH9X++tZ+1nrJSbo9s2x
         y1Lky8y2efjjNmzkmwBfhCP0MMWkRI+wH1mVxldp/h/6BKS7vD/1sXVcZpgzEcy11CVg
         auwkQRbMpw/i/K65IlCcT8LQa3SbBwi+0VEjHD4xlAFr16Eg3hHlEZp6V86jsF+qWPHz
         f777jKfTvWwSoi8H/nQV+6gVru7qhU9MbWUhXmBLNN0tHX0FOUWRjEHkBTG+aZpGA+RF
         tZSv3rAq6/rmisihl4W2rLwbAuv/WsOxWRTDoJmve5s77dNIKiU2bzjVVCZkMZnGF3f9
         UDmg==
X-Forwarded-Encrypted: i=1; AJvYcCWN2kjVBN1Q91Mlaqm/6hN5Nw/SOy6mNAfQboUU/Jm4686lfHUdkz3OswnrC7WwqO9j1F9WhMJh@vger.kernel.org, AJvYcCXg4UpXrPWo+xjAPP/Gzg3cWJLRy0ffGg0FTijNt71z0cl21pNTGQA5SZKkg0OQoJfTq24Or8G3Yxul@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mQ9dFWeB89qx2vSnYizZwTuk31xXDivMo3f1HykcrnTfHLBX
	4x94pHllTRQ6XEHvH07OecZpgv+75IoWmwRI8m9l090O1Nr7Irpj
X-Google-Smtp-Source: AGHT+IFMKiBnMdA+T1HdrdVOPmK1vpftzXKrzhjlvBxRZ+6XVahDDgfE1v3Blmc+f8mYOWFCAXZSnA==
X-Received: by 2002:a05:620a:2a01:b0:7a1:dfe4:5708 with SMTP id af79cd13be357-7a674027b83mr63061885a.16.1724188031098;
        Tue, 20 Aug 2024 14:07:11 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e3592sm562387385a.92.2024.08.20.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 14:07:10 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 36B6C1200043;
	Tue, 20 Aug 2024 17:07:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 17:07:10 -0400
X-ME-Sender: <xms:fQXFZieSUsaLtAoRB2fya-NsnJqPFxbmYs943G6PP37g9ppTsww1gA>
    <xme:fQXFZsNgYXZ5X-VhxwLgKnWFxMXSRDbiTcgJFl10oJzwOm1jFtIjRI0ZwaIxZhvXk
    NPl6McsJC1ZCLJkWQ>
X-ME-Received: <xmr:fQXFZji9iSnA3D7f7HLrcMgVo86g6V6C205pvAgC78gNjxJFXJ2uAEmTPks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghothhtrggrfigvshhomhgvieeffeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeif
    ihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshihiihkrghllhgvrhesghhoohhglhgvghhrohhuphhsrd
    gtohhmpdhrtghpthhtohepshihiigsohhtodejfhegrgeifhejfhejtdehudegjeegvgeg
    tdgrugesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:fQXFZv9MKbTRWwleM5a6NeyeVRWqYJGUNMne20VmIlWK1NbKYHjppw>
    <xmx:fQXFZuumGiquPq7Wn-iYu9M1_ytiiUdhMiEAr8AuaBoE_ylXKUPciw>
    <xmx:fQXFZmHQ2goz8bwzt1e-FbQSXwwjZ8H4BFw51QPviOC27AyFz6m6ig>
    <xmx:fQXFZtNwa-CkXxrfv0t9yHksIRdZ1pU6TQMlasbXe7YdkD2qOeZNcQ>
    <xmx:fgXFZrNoURonOLD0kdF_EVw_f-fMqha6ap6YucbPhCOzujDpDgGAEfra>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 17:07:08 -0400 (EDT)
Date: Tue, 20 Aug 2024 14:07:05 -0700
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
Message-ID: <ZsUFeQP3tz8TXxrU@boqun-archlinux>
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

Hi Ahmed,

Sorry I was missing some points on title and changelog, please see below
and refer to Documentation/process/maintainer-tip.rst:

The title needs to be something like:

	locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

the title and the changlog needs to be in imperative mode.

On Mon, Jul 15, 2024 at 04:26:37PM +0300, botta633 wrote:
> From: Ahmed Ehab <bottaawesome633@gmail.com>
> 
> Preventing lockdep_set_subclass from creating a new instance of the


Same here, s/Preventing/Prevent, and when you reference a function, you
want to do "lockdep_set_subclass()" instead of "lockdep_set_subclass".


Besides, overall, you want to structure your changelog as follow:

Syzbot reports a problem that a warning will be triggered while
searching a lock class in look_up_lock_class().

// ^ the problem statement

The cause of the issue is that instead of the existing name of a
lock class, a new name (a string literal) is created and used by
lockdep_set_subclass(), and this results in two lock classes with the
same key but different address of the names, and a WARN_ONCE() is
triggered because of that in look_up_lock_class().

// ^ the analysis of the problem, you can merge the above two into one
// paragraph if that works for you.

To fix this, change lockdep_set_subclass() to use the existing name
instead of a new one. As a result no new name will be created by
lockdep_set_subclass(), hence the warning is avoided.

// ^ the fix.


Please send a new version if these make sense to you. The patch #2 also
needs some changes in the title and changelog, but since that's adding
a new test instead of fixing an issue, you could just write something
like:

Add a test case to ensure that no new name string literal will be
created in lockdep_set_subclass(), otherwise a warning will be triggered
in look_up_lock_class(). Add this to catch the problem in the future.


Thanks!

Regards,
Boqun

> string literal. Hence, we will always have the same class->name among
> parent and subclasses. This prevents kernel panics when looking up a
> lock class while comparing class locks and class names.
> 
> Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
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

