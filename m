Return-Path: <linux-ext4+bounces-7113-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144C0A7FA32
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478593B1E5D
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C5263F5E;
	Tue,  8 Apr 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL/aNXBm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCE8227EBD;
	Tue,  8 Apr 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105445; cv=none; b=sGkzqGPl9Bzb1UgNCAJoc89JBQPBN5MXsV6ZQEX9MgGr35i5NrHNeuSH7M6evgn+fB6zNfBfmWrQMWqV3v8zrIcUch5mh6VkrrW3JHwrV2b9iq0xaqKVWQqDWXndlTQ+bPr7Hb/CDhm3n9MQxwLh1Iu+7PtRvfkao8fxQ/KDqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105445; c=relaxed/simple;
	bh=NbLpxgTlEDHBmSQEbuRxAZe25sUbMlewPr1bXApvVMc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=dQrHZ2JXazxKv2+ZAsnjG4Zweuhla2MQg0KvAb38Z+j5PvfW8gRFXlmZpX0la6E0H90EHfuFRUtaBLkRutoD5TwPABTVj+8594DwBxwewQiilcvFjHsmDazhlGk3wN2ZkD0ib12uMpUxoNpKju1BWc0cNyMtJXKFeZWQ+TX7avQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL/aNXBm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7369ce5d323so4170991b3a.1;
        Tue, 08 Apr 2025 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105443; x=1744710243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgcCW0grI+XNEqVR+uIZZFc1/+jtL1OXtSCzifUzj7A=;
        b=FL/aNXBmSUyp4Dr9lC84Gex4ugIehWD8cWZGAmqmM5kdBAOXQUtY+8vi78scyYKBkn
         TpuNeJejVUUKrqFQPA7qj489s5tytIFAyWGahNUA/kQWy5uwweB2GZJQEBnCM+XHpCd+
         gZ1AefyhA8nCIukI8DuNUbGqti2NXtY+A4shf9v0cClklNk8rr6b89fL0z/CTecmvksH
         rrqlkgjD4YL9FfFpqeLszObh+v8C+y1gZf06dym/TZOZpO75qI9G9LnUP9D5SF4Xgecf
         WhhQn/itxvrVjCPC5XNSnNI2tqwkOgXhJBbtBHx0QG+xl9Dos2RS44cIgxMrZBTcnlIB
         Ik9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105443; x=1744710243;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgcCW0grI+XNEqVR+uIZZFc1/+jtL1OXtSCzifUzj7A=;
        b=QIGbeC3oMSKg034emVVgV86Dm1c7OzqoO56EVtxPdqo4Y/BiycpnzU8rmOIl3tW6N2
         aUGfyT1xVnnWhIS8Mm5MatVy9+GEXJPO6bL+g/Ql0fkXyuD26NzpKqsLFPzrlrTOe8aK
         RhCul3Ql2VnPhG+CX7zmWySzu+ysNdH54mxOAphzzxc2tL3zsBTnTmoxCqHtoUVYfd/j
         XjcK/RqpS9eTJe1hBljFGzkcTnQSeLHqocRMYJoq6lV3cdfQAFAtFPXffsNZc2VZVly6
         1mW6wjC2YvIoPUBlND+Bq5WjjUwBlA826o9TfMKuXxW08WXS7lu0ES+J9iRdaUXUYU1W
         ecXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwf0llQYa8dsgDJbJLA5LZqGX76fyGqkEiicG6cyPcBBBPM/70zwS9EZp0K5IGd3smclD7RY8V2Ud@vger.kernel.org, AJvYcCWBFzDVWS5N1uSY/zLhfI150CJb32P+5PdGV6oCOO9uC+qiiXPCcZzeTxqRjNmKWV1ZnJm2wLCr@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDYkyWVqbDZEpWWUv7MZPWXL6c6HqsP4lsihrWZUGyVkpysgH
	2p0ESDiSaQLRdYgWppeybdjb0IlcZgn+kdaCpGxgytrPZuHGrMyW/BEWBA==
X-Gm-Gg: ASbGncsEvQNNpEw91T+3CM/gV9218N8M3mimTAkP0EGRbv2NZrmceewbkeDM+pNsrYH
	Qg6t0hAv5vUHzIwb70/4rzrb4uulLV7x/G1PYhOWVbBQ51hAGhXO8TjZzL0zkvrKwObJ2t+zA5f
	CkiHS9N4ALw9WvPix22P5KbfZrg83DB8gA8ATbuvFjX7dtgjYtjSUtDtR9rPsLnskXye1IS7CIu
	zNcM87GCy9XVVF5PiRqMu7rmIhqo8IzVAGpF/2X/gLfmfCgPh5kUwEYoPzvWhQgrPSP4GXHocms
	P36AC/sHwYA88tL9FTxI6E8s5lARAsh4COYVK+lkx3rNTw==
X-Google-Smtp-Source: AGHT+IGWBJF1VGZJq0BivxZlMQFXZOeDcHdusaw2wKYvsxXBdDj7EFYnwBOSfrbauQh9Bgkot0U/Zg==
X-Received: by 2002:a05:6a20:918e:b0:1f5:5b77:3818 with SMTP id adf61e73a8af0-201081394ddmr22687594637.27.1744105443358;
        Tue, 08 Apr 2025 02:44:03 -0700 (PDT)
Received: from dw-tp ([171.76.81.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41c626sm7158156a12.78.2025.04.08.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:44:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around exit command
In-Reply-To: <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
Date: Tue, 08 Apr 2025 14:43:41 +0530
Message-ID: <87y0wbj9ru.fsf@gmail.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com> <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> We should always set the value of status correctly when we are exiting.
> Else, "$?" might not give us the correct value.
> If we see the following trap
> handler registration in the check script:
>
> if $OPTIONS_HAVE_SECTIONS; then
>      trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
> else
>      trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
> fi
>
> So, "exit 1" will exit the check script without setting the correct
> return value. I ran with the following local.config file:
>
> [xfs_4k_valid]
> FSTYP=xfs
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/test
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
>
> [xfs_4k_invalid]
> FSTYP=xfs
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/invalid_dir
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
>
> This caused the init_rc() to catch the case of invalid _test_mount
> options. Although the check script correctly failed during the execution
> of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
> returned 0. This is because init_rc exits with "exit 1" without
> correctly setting the value of "status". IMO, the correct behavior
> should have been that "$?" should have been non-zero.
>
> The next patch will replace exit with _exit.
>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/config | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/common/config b/common/config
> index 79bec87f..eb6af35a 100644
> --- a/common/config
> +++ b/common/config
> @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
>  
>  export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
>  
> +# This functions sets the exit code to status and then exits. Don't use
> +# exit directly, as it might not set the value of "status" correctly.

...as it might not set the value of "$status" correctly, which is used
as an exit code in the trap handler routine set up by the check script.

> +_exit()
> +{
> +	status="$1"
> +	exit "$status"
> +}
> +

I agree with Darrick’s suggestion here. It’s safer to update status only
when an argument is passed - otherwise, it’s easy to trip over this.

Let’s also avoid defaulting status to 0 inside _exit(). That way, if the
caller forgets to pass an argument but has explicitly set status
earlier, we preserve the intended value.

We should update _exit() with... 

test -n "$1" && status="$1"

-ritesh


>  # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
>  set_mkfs_prog_path_with_opts()
>  {
> -- 
> 2.34.1

