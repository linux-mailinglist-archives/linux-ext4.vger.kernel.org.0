Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7553E1D30
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhHEUNA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhHEUNA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 16:13:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D74C061765;
        Thu,  5 Aug 2021 13:12:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g13so13415044lfj.12;
        Thu, 05 Aug 2021 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cDAy/hM62deBfq6ttiHsWSYbyGEgdxOznCk9r6mwx4=;
        b=Bvvt5aoIWv5dVzyfr07BljucZerag+oOkWwMSEKFgMx3wVi8bOjWIdGxPUm1c/9ahz
         4zzOFapuFIr2z3Tv6vHEJyEfOUZZ44l0Ws5yh9nDP+/usyoFx9wT1pc33Ol15ziSoSha
         jsrXc41dyOaFb+VdqgbZpRmXqV+jLlSQtMCkMo4p7U9cxZqm4iPR6vEp7zuN61gGdKjx
         XF7q4cfIGB5gBjTNAzQAAVgAq4u91j9PfyGkesAwG5Hmm97zTB8HTSkVbC2eY465RUhv
         vJ0ZVfy83TnRJiE61GX5bpEApt10KBUP4j3Tqm+OvDFxhgFRH2FtO6MFbI2N9eAcj13f
         AhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cDAy/hM62deBfq6ttiHsWSYbyGEgdxOznCk9r6mwx4=;
        b=rEQqvlN5AgZddzz3VNyhnai8O6JvpoEL9YTSDS3X2nUPf6bswZNd9MVr31mrx2Gwe3
         aFiXyfOC3lo4SdFbhEICufrgQmr2CYsxM8nJqKPG778G4fGC83QkRXQgJY/3jeeCByjZ
         oMq0ZfSTgMJWw0p4HKhEjGyasPaCF59q+QYdgxRP0eRNHiG5Wj3iT+JK1lpqOP42msMc
         qSxUZPXHwBSu9e6Bxml7buuS+B9XgDIbu/Z6rzQJnue2Dp9wZkxxdV/Dp7+ntaK4kTR+
         xhrShj5qUjhwvZFfCvb+rJJdisS5VGJihubJIiJZQaGOAD64Jc1B0/VhSBEbV8UyPse3
         mJWA==
X-Gm-Message-State: AOAM533re7EMkbXd9dmm9U44cKR7hf+2AZkCmTwD2fBH5AxVTnx50JsC
        QHg3VJ8zk95cul4r7DRljdY=
X-Google-Smtp-Source: ABdhPJyM3E4/+J/uczIZaXlDC8WCiou9HizPIzeO8DQM13cPc5t9e2D/4PGHwJPSXvnU6AQZdkcKIw==
X-Received: by 2002:a05:6512:b08:: with SMTP id w8mr4739545lfu.557.1628194363516;
        Thu, 05 Aug 2021 13:12:43 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.226.235])
        by smtp.gmail.com with ESMTPSA id a12sm312970lfr.305.2021.08.05.13.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 13:12:43 -0700 (PDT)
Subject: Re: [PATCH] ext4: avoid huge mmp update interval value
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, johann@whamcloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
References: <20210805151418.30659-1-paskripkin@gmail.com>
 <YQw/2PuZ8z22Qice@mit.edu>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <2e940500-6d77-2871-407b-201ca29f24fc@gmail.com>
Date:   Thu, 5 Aug 2021 23:12:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQw/2PuZ8z22Qice@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/5/21 10:45 PM, Theodore Ts'o wrote:
> On Thu, Aug 05, 2021 at 06:14:18PM +0300, Pavel Skripkin wrote:
>> Syzbot reported task hung bug in ext4_fill_super(). The problem was in
>> too huge mmp update interval.
>> 
>> Syzkaller reproducer setted s_mmp_update_interval to 39785 seconds. This
>> update interaval is unreasonable huge and it can cause tasks to hung on
>> kthread_stop() call, since it will wait until timeout timer expires.
> 
> I must be missing something.  kthread_stop() should wake up the
> kmmpd() thread, which should see kthread_should_stop(), and then it
> should exit.  What is causing it to wait until the timeout timer
> expires?
> 
> 					- Ted
> 


Hi, Ted!

I guess, I've explained my idea badly, sorry :)

I mean, that there is a chance to hit this situation:

CPU0				CPU1
				kthread_should_stop()  <-- false
kthread_stop()
set_bit(KTHREAD_SHOULD_STOP)				
wake_up_process()
wait_for_completion()
				schedule_timeout_interruptible()

*waits until timer expires*


Since there wasn't any validation checks for mmp_update_interval, CPU0 
will wait for up to (1 << 16) seconds (s_mmp_update_interval it __le16).


With regards,
Pavel Skripkin
