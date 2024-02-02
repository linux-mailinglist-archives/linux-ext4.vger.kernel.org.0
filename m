Return-Path: <linux-ext4+bounces-1067-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC93847940
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6471C203DE
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E128175E;
	Fri,  2 Feb 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFZhtfgO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546A8063D;
	Fri,  2 Feb 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900780; cv=none; b=V4d9EQP9TVfsiUF/4oVtBqA3Ujx5lc/zZGGp3WTyUrxteNWwZoS2EeRMkYHdKOmuKplbcQqPiWJXxhm+ahVRcG4fRDrgdQoTPqXrVNU0b01OSM7+T+/6I0wlXVD8n7zTsUSsgxlkSdi32VpkX7WIasCIst27AS3ielPRk0IeoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900780; c=relaxed/simple;
	bh=ohvLMN/lkjg6HJuHcx4yTNCeRM8R3822wjzvi5cNijU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb6TQsa8luTUqWWY+4bHaPVzFspXlIjQfDmAOUC2sHGxQ0kLRytojUZmfi26CTGo6W6LYvILwLs4qbPhTXlsdxlpmKi0zoDVE6ohTOHMjPemk+7lQIYWnaE+f0DuTyfV3+8/yNMOg4DL11zrVOu1FyECP9FG8/r4udecWL9LrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFZhtfgO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783e22a16d4so263164785a.0;
        Fri, 02 Feb 2024 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900777; x=1707505577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqOS8N2cJiuLBdJn3hLDtD0IeDZMugYcr1CjsPB4GHA=;
        b=PFZhtfgOfgtIZOe3p6Ea3XBzC6SjiwAxYugCay1LZD2g7hNVazlV3JEJof0v9gQ7yN
         6Dq0gCJSoi6fANI30WlaeevzG/Tsx8JUR4ej7oodtKgDbooYYX71e2RxIfACGTsMNZES
         zhl1ZRUa3urgp6Qu3QzH//TIjBynoYw3ZgmTy0b8KsjotMKcfxsUuxPlLsVR95bEToel
         6dD9vAIJnMM3/+pl8pDS9aYWW605Ue1WAPRb8KeE2cvCCLgxjKg15D/VUsUNuDl8+OlT
         IfUXCCfJBa5hqwmN17MBqUgCEShJ/IyXwg/PQEdBUV57wm5x/rxZWMxf5AzmnJKv6NNH
         fh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900777; x=1707505577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqOS8N2cJiuLBdJn3hLDtD0IeDZMugYcr1CjsPB4GHA=;
        b=bENOcOe3NzvVYR6Fw9mdhAa1IklO1eg5h9Z0blyYsy9aeLqKqVlAlku/LdUAdTsNSC
         tGo9FzOMxMp6ps9Aqk4ANQdfxmT/Kpav7DyEqbaZRvDIUE3yBBI6kOmjQEeDjZH1WN0a
         +g/9g/Ni4OYvdx8cKk7KsF+ebn5qcGB2F5snYmZincGLJn7CUmet4IwTNin9m0FpP6Bp
         fgkE3Hnq7cRkYUMCgbkyP/mUWt+M+mg6hOkbz100BnJ2Mc8cFBOWxKkBVFwkcVHjTZGq
         tcSbTh6h1pHp1a2r6Ov6QeFMoTbGhczUQWInbOaJi8D1JNgHaCmrEoJlsvtLcLT1PTth
         LjYw==
X-Gm-Message-State: AOJu0YwSFVVTXELe6Wtidg9ccyUcjj4hXzBze3yfYTfaErIYNFJn2P5k
	NDp8xcOXzLGDp0XREjkzfb9QGl0otLnsh5EOPkPLv/RwllLcsF5c
X-Google-Smtp-Source: AGHT+IEM8+IhRnbEgh6CVkE9SkTCRsB5VjLZ/73sTor5W2FxW+gQ7t5qenIiqSW+5QfvXvEzYzzs6w==
X-Received: by 2002:a05:620a:1342:b0:785:3bbc:9ab4 with SMTP id c2-20020a05620a134200b007853bbc9ab4mr5127111qkl.1.1706900777459;
        Fri, 02 Feb 2024 11:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV00NAnQ/yL9cp8ABoYtzkXtnan8Kur/2rbF9JG3wGW+EleZeeWQC+vpIs9mGReRNQQqzlsz783gSalVkbCkJLX9RY+17ytj8GdkvaT4SLQv3ivzi/A4ZevMqwt678LnYxWKnNHuTxkdmPA+NdbKnLwLto=
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id br14-20020a05620a460e00b007855df9feabsm374687qkb.3.2024.02.02.11.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:06:17 -0800 (PST)
Date: Fri, 2 Feb 2024 14:06:15 -0500
From: Eric Whitney <enwlinux@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Eric Whitney <enwlinux@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/459: don't run on non-journaled ext4 file systems
Message-ID: <Zb09Jy8KyxoBAnEN@debian-BULLSEYE-live-builder-AMD64>
References: <20240124195306.1177737-1-enwlinux@gmail.com>
 <20240202131529.jn5z64qfm5r5ibte@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202131529.jn5z64qfm5r5ibte@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

* Zorro Lang <zlang@redhat.com>:
> On Wed, Jan 24, 2024 at 02:53:06PM -0500, Eric Whitney wrote:
> > generic/459 fails when run on an ext4 file system created without a
> > journal or when its journal has not been loaded at mount time.
> > 
> > The test expects that a file system that it has been unable to freeze
> > will be automatically remounted read only.  However, the default error
> > handling policy for ext4 is to continue when possible after errors.
> > 
> > A workaround was added to the test in the past to force ext4 to
> > perform a read only remount in order to meet the test's expectations.
> > The touch command was used to create a new file after a freeze failure.
> > This forces ext4 to start a new journal transaction, where it discovers
> > the journal has previously aborted due to lack of space, and triggers
> > special case error handling that results in a read only remount.
> > 
> > The workaround requires a journal.  Since ext4 is behaving as designed,
> > prevent the test from running if there isn't one.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > ---
> >  tests/generic/459 | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tests/generic/459 b/tests/generic/459
> > index c3f0b2b0..63fbbc9b 100755
> > --- a/tests/generic/459
> > +++ b/tests/generic/459
> > @@ -49,6 +49,11 @@ _require_command "$THIN_CHECK_PROG" thin_check
> >  _require_freeze
> >  _require_odirect
> >  
> > +# non-journaled ext4 won't remount read only after freeze failure
> > +if [ "$FSTYP" == "ext4" ]; then
> > +	_require_metadata_journaling
> 
> I'm wondering ... won't other fs need this, besides ext4?

Thanks for looking at this patch.

I'd been mainly concerned with ext4, but since you mention it, ext2 and ext3
ought to be added as well, since the failure behavior is similar.

The check for metadata journaling is limited to just ext4 here because the
commit history for this test appears to suggest the touch command workaround
is specific to ext4.  Perhaps the test should unconditionally require metadata
journaling for all file system types, but given that I don't work with many
other file systems I was uncomfortable asserting that in this patch.  If
freezing any file system requires a metadata journal, then it would make
sense to do that.

Your thoughts?

Eric

> 
> > +fi
> > +
> >  vgname=vg_$seq
> >  lvname=lv_$seq
> >  poolname=pool_$seq
> > -- 
> > 2.30.2
> > 
> > 
> 

