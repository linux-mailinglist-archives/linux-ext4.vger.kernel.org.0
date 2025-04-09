Return-Path: <linux-ext4+bounces-7150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2AEA81A01
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA07C19E00CC
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 00:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAAE81732;
	Wed,  9 Apr 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="itUSnmxh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838478F2B
	for <linux-ext4@vger.kernel.org>; Wed,  9 Apr 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744159449; cv=none; b=DkIjNI80MQxQTl2L7zh5DzGZHCuhhyaXZNZoUjBwzdWP1oyJuZPGcqEmauKzlyIO4VhzRdIDUuivjgqNszJHvX4NSng4ffWotlTAQIrGGfFUVjgf5sQv6WwglvKvIMY+eY6V4AwkzNPxVV6G6HdCj20+kKjdOJILamkZ25uhE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744159449; c=relaxed/simple;
	bh=iHbfk/XWM7ppbOvOvQ6qi64KcVzkWoSVIBABMFcVRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3qiS4rAh+fOMyOXnhUUDpbWhrrtYTon7mnbCidwHKeyHLeWPCEkVQplzvF/VvO8Ds9wv/XBKcwnzFeKHNoNqRgkC1zoR5gjpB9nFQ8r0pTx4OjBt47dE7QtVinWmNJIbE8/glgKYWGEmxLlm0oAsSvHYA+3cJrjPdnwJbYApkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=itUSnmxh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739be717eddso4866933b3a.2
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744159446; x=1744764246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbxqBhkLvik9isyhyqh8hX9+mqPhV1OKGBEqeSrqBcY=;
        b=itUSnmxhhfoXF514hMPqJ4W8dHno1m2oK+PpUUN5LCThk/km0gEuXpitxa7X21Iw+k
         C4tqbbD7UXm5BsgnnnzkEnbotKZpjsWKFXWO6VlWOJOC50SmCA2t0MfniKilKjnNl6oh
         hc756F2C5pNZprdKWfP/E7PNIVyZl/FppqhYJbMDXgjUpOefkTSV1Im5WMdAPzfJHJKR
         9o51QsJYJrfJx6kcgX5QowBKC/HawOJKIPqKAHXKm2+GBeszUEYL1u/yycDa9681P4OR
         UMyt81+TOYgrHZGp7VzSs9t23zyfqAHMbwJRU1Ib+PxOgp6W38oh9gURdGLO84BO0RCT
         jVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744159446; x=1744764246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbxqBhkLvik9isyhyqh8hX9+mqPhV1OKGBEqeSrqBcY=;
        b=wt2J7oHxZximX3tYASt5veVIK+yebACInHliYiluRt3kR/i+c8Wo9wDw2I5be5AeYL
         ln4PYFqRYEWSoimizi4a02FN0BBfLKTGJUGog5F/yzRLBJDmW6byF56s8/I6MFb/J1wz
         7uXikIRMqkbMezc92s36j/O86goqip/2I+QVJT0DCKI/un5Jk3DxiBt07+kJQQ90se/+
         EDKidHVB6SzYxewPtizh5hErQ4y/Lw6Y9FZuYzjFW2WsmC3SrVcLpeoVSDR3eTwQphh4
         6iKCMBG5cTtcRyG35jNt0B5VfGX6z1KAPCBtOPDYqCTMiYIsCD8l4XIm5C1BG5TK++jh
         BReQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVgZs5lcwGU4O2OBnAcpahJUqlYuuwXreR+PqfdHrZHF+QvDqd1Oa4QdijKO6dmFMIVK5fLTxNHYct@vger.kernel.org
X-Gm-Message-State: AOJu0YwGETCsT3Qo4fUglNRzPn8+ltEZuQRgbS98Aps18MSBp99dudYJ
	fW/3/FcNIW+6j/2B2g3zBFZl+oHLdyWJ9Ob3XfF8k9flAYfbvVaIulPZy5Art+w=
X-Gm-Gg: ASbGnctAnZxVT2iaJ3KPEExZX4eOmF8jHJAdJVrjAcXzqKMKADyuYMMk3RnzJw7ZOHI
	uvNG38L2ooOzxgrBRWuTG5xmO2JSjgwomzat60yhmX3+DTNfxYmhXnPzJEVr91X1YChuax3zmOX
	1LF27BysnqVcHbOQ0sfnNlDca7buO2lAFr65ZjshQh1KeG/Cm8NXjcySusogH8nuF7BXGSSmT19
	/0NiIXRzU37t0lP4kYudHl5CXS8+Bf2+bYpa+G6to1Zn/MW/JFdM82Zwsg39IitW7Qh0vEZDpmu
	Mx580WHPPEMnsWchdO9BDCJxVqKnAGqOEkS+9pWRDYesEFLlIhtHAmV3ZYqkE1fIadmadM+IOQ0
	jmwLqv9E=
X-Google-Smtp-Source: AGHT+IHMeo66q/hGrohL61FKn52NJ0cl6OjqSIj7QkxbgAFmrHfwOv4cZSsuZcNyl4l8ueFDICgAAQ==
X-Received: by 2002:a05:6a00:3a12:b0:736:34ff:be7 with SMTP id d2e1a72fcca58-73bae52a063mr1061739b3a.15.1744159445981;
        Tue, 08 Apr 2025 17:44:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea0a7csm11673182b3a.91.2025.04.08.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 17:44:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2JXu-00000006H8B-0w0d;
	Wed, 09 Apr 2025 10:44:02 +1000
Date: Wed, 9 Apr 2025 10:44:02 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around
 exit command
Message-ID: <Z_XC0sMObxxHOWM5@dread.disaster.area>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
 <Z_UJ7XcpmtkPRhTr@dread.disaster.area>
 <37155b56-34ba-4d5d-a023-242abbe525b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37155b56-34ba-4d5d-a023-242abbe525b5@gmail.com>

On Tue, Apr 08, 2025 at 10:13:54PM +0530, Nirjhar Roy (IBM) wrote:
> On 4/8/25 17:05, Dave Chinner wrote:
> > On Tue, Apr 08, 2025 at 05:37:21AM +0000, Nirjhar Roy (IBM) wrote:
> > > diff --git a/common/config b/common/config
> > > index 79bec87f..eb6af35a 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
> > >   export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
> > > +# This functions sets the exit code to status and then exits. Don't use
> > > +# exit directly, as it might not set the value of "status" correctly.
> > > +_exit()
> > > +{
> > > +	status="$1"
> > > +	exit "$status"
> > > +}
> > The only issue with putting this helper in common/config is that
> > calling _exit() requires sourcing common/config from the shell
> > context that calls it.
> > 
> > This means every test must source common/config and re-execute the
> > environment setup, even though we already have all the environment
> > set up because it was exported from check when it sourced
> > common/config.
> > 
> > We have the same problem with _fatal() - it is defined in
> > common/config instead of an independent common file. If we put such
> > functions in their own common file, they can be sourced
> > without dependencies on any other common file being included first.
> > 
> > e.g. we create common/exit and place all the functions that
> > terminate tests in it - _fatal, _notrun, _exit, etc and source that
> > file once per shell context before we source common/config,
> > common/rc, etc. This means we can source and call those termination
> > functions from any context without having to worry about
> > dependencies...
> 
> Yes, I agree to the above. Do you want this refactoring to be done as a part
> of this patch series in the further revisions, or can this be sent as a
> separate series?

Seperate series is fine. You're not making the dependency mess any
worse than it already is with this change...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

