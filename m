Return-Path: <linux-ext4+bounces-13584-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHnfMEPxhWk+IgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13584-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 14:48:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A46FE6A3
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 14:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA59530D8661
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0523DA7EA;
	Fri,  6 Feb 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNQdFPLZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAD3A0B2F
	for <linux-ext4@vger.kernel.org>; Fri,  6 Feb 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385244; cv=none; b=ELoAf3so1nnIe6qJkOM58ewc63XEXiemtTbxhptA2bOBDVpIZmNl+I/z02G7scI7TyBv5zDmMt84hGqv9p7jRVzZjW0r8XYNH75CZ4LeRO/PM5a3D/q33kNgpIyVaqzpMOmZVswokVp4ut00neF527LESAxvCLqK3mD6Q2l1NSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385244; c=relaxed/simple;
	bh=apxHwkZcP2HO2OZanljlp1u2QbHEfBt14zrOagr9PhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jvjFaqSDgGLwpRg4QaKs9navQq4eXMseSJ9+FVVcJoEkP80G86TvLVnAX1LI93N1Fkb/fc4QBiLvWfqfMjxNWtuMTJNU/GXN7kWIZR2FAmJ6tNniYE/Badkhumw56JcawgdRxBXd53n2gHvx0JDRfAuzzlbFJSVputzG/vzJ890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNQdFPLZ; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4805ef35864so18795905e9.0
        for <linux-ext4@vger.kernel.org>; Fri, 06 Feb 2026 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385242; x=1770990042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/0TLoJXsgtAsaIN9YWRMXXg5Y9BBytnoGjFk4CYjlk=;
        b=QNQdFPLZIIu0S2tGyN8BN3D1PBny7bJtsLW94+LWr/zoynmJ9bfietkEvFdp0mr8ft
         fN6QB+rC1j5RNqw4sM+3DQbQMWXxxRAJ+xdik+usPFw3LDR82gDJXAihipo3GYvIB4p7
         8TS42A3/5bSP5F6/+yVCumNUVQKguc7Y/SL+m9VWTovBreN00NPdjYKWdPCEyGG1kUQH
         Po3Mj7p9V5XhSaCxa+GHabOj9SDcyRL1d1fQm9OMEPccEndWe/huCX6ILsk6PX1a4Wu4
         bdMtUbHSahs2TNXOc1Rh0YvlS1IST12WWgQOTA6qTW56fUezGCYaquNY8Buxop/7oJse
         vNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385242; x=1770990042;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/0TLoJXsgtAsaIN9YWRMXXg5Y9BBytnoGjFk4CYjlk=;
        b=ZD28WwzKPKY9VEBeMyWN4RLIPMToWYdIaO544iaOg9hubQ3eL7r6lnBtxQyx0RRQMC
         UU+p7YLk+yZa3XDeoUmTL22R2QhB9pd+agaARNNKsgTkA5hQ0Yidxq231bvYHyt2j90g
         vSWD7ktvSLzIVSSNK0tflyYJmHn8WY5WK1aO2b8T/fQ9YasRUTYCMguKSMNz1AscB3Ig
         hG6Efa+DypGCtK7HBq5OviJc6aHrIDdB0MMk7Lww//bQOwEAXvYVBfmnl3tH1jNtbBLs
         CGrrWnnKV7AKzc3j9Q7TPs/T2cWTdzxpPNwlXkcR8tj8Z0zhrjOK+Uk9dpSUwNqiwyL7
         oevA==
X-Gm-Message-State: AOJu0Yw6wKpruqPJ10qDMWe0bI1NgfepJGOTszX0mipOYUkYoTF6n35D
	IW4KaZ/dVFc9DKzM1xwTnk0AsbK7xV6yjiPzdZ7VKEb+z7XgPS1K3XuuKVbjP+Rh2k7N7AlA9ys
	69Wap
X-Gm-Gg: AZuq6aI6TZ9bZsEomjh4E4POsnEeGTnMTVaTzAy8PvUj5j8oiNbph/EJW5Wp9YM5zJU
	5XdoHwS8Jb3R/RylhL+juZviLQ3O1OK6jHueaDYJgP/y+qmzv+eD9iTA52I3ELdIgTCstTxs1VF
	ydhhiM+nzlILaYcM3tfLn2yffZPcPBksPGfXsub1QhNU2kajqjfReshG9C/sxT+egA7bBcSazZO
	a3lKw102W4wwPUnZctcbu2SpxtQgBzP0A3LEP+8T1CSlBPpBUESoFt9M5S/gJu3nV0fPhFtZXdp
	IbZLFO4ueaEfbQ2bggdIv/ZLHA8z/IM9/BgXf3Gh9obazzBdUuvNqfY8TyMyBoaShudowFS0nUK
	ZWEF+Hhdt0DQld7om+c4QYyvuFJDTkr+9X/KYkVS/3RJ1zcDdvzfwWY92UHCFzRviUrSS+uHmFa
	O1GHGUXgWeBQPY5nbD
X-Received: by 2002:a05:600c:4fc1:b0:483:ea6:8767 with SMTP id 5b1f17b1804b1-48320228160mr44676465e9.36.1770385242074;
        Fri, 06 Feb 2026 05:40:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2110sm5812451f8f.3.2026.02.06.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:41 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] ext4: refactor zeroout path and handle all cases
Message-ID: <aYXvVgPnKltX79KE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13584-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,stanley.mountain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40A46FE6A3
X-Rspamd-Action: no action

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Ojaswin Mujoo,

Commit a985e07c2645 ("ext4: refactor zeroout path and handle all
cases") from Jan 23, 2026 (linux-next), leads to the following Smatch
static checker warning:

	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
	warn: duplicate zero check 'err' (previous on line 3363)

fs/ext4/extents.c
    3361 
    3362         err = ext4_ext_get_access(handle, inode, path + depth);
    3363         if (err)
    3364                 return err;
    3365 
    3366         ext4_ext_mark_initialized(ex);
    3367 
    3368         ext4_ext_dirty(handle, inode, path + depth);

Presumably "err = ext4_ext_dirty()".

--> 3369         if (err)
    3370                 return err;
    3371 
    3372         return 0;
    3373 }

regards,
dan carpenter

