Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07D24E2AA
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHUV0j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Aug 2020 17:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHUV0i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Aug 2020 17:26:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CA7C061574
        for <linux-ext4@vger.kernel.org>; Fri, 21 Aug 2020 14:26:37 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so3136486iod.1
        for <linux-ext4@vger.kernel.org>; Fri, 21 Aug 2020 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPqxc4OgKI9Opavzdh3uvDImVIna5oiu3wI1Ldz2iFA=;
        b=1J4ZCEzpws6MSvmSIYNmOl9EqXEPcmOnwafmyG+kOO9ex9UTRKycw/6xVqQzxDRhC9
         h3n5iJFbcdJQrMqI6vGFrBxW5e2WSgMTVlDwU+9pTBwr+Oijnro6yvOMEINT8JXfeyZz
         AujmHREjdOrfoYhnwn1PdDvEZPc/WvWNe6T5R/BdxtA3yMbR5WJ81VI2DuuoeP3ECXQf
         Qh65RGtzCTzYfTXPbLpwAvndmlFbxCCr4MNULvRrRoUjrFjBc729y6zISEoa1Kx2DlFH
         r5dkUDloddOMRfIy9IMkJOhwllKz50K/riJHm9kfxZ4Qqf9M5E+Snhvhk4errJyF1H68
         o4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPqxc4OgKI9Opavzdh3uvDImVIna5oiu3wI1Ldz2iFA=;
        b=ppP1SJIkhsDkn4Y1DT2pn+8LARaKUjFEpSVmWhFBE0/RM/NNj7WO3EyxYKMACU4uNv
         clhgx2AeH2eYIzMTHDOIMxRjbVZP5hln1kjZSCdxgsrau/6MPoeo22nYkUXqZkxOcQIH
         0wsoE7UHIydiewNdpbIpP48uF7Ev5klc3c/AiLcORPFQJ0bMfzhiEK1pj2sIWW12cwLS
         plwDD/5b9X2qISqX6+5A2zFgdeWt8c2ASTbcxirMUvlJZLOHfVdY0bmdBgt9GTKZL8x0
         bC62luAsMJ3wb6k5p47mZUGh4PfccpIgr8C9387StfcP2v5G8JiDpnjb3Z+cRPL4fx/V
         nKuQ==
X-Gm-Message-State: AOAM531o6IGlTopZk/AYd8z3xYRqNtECB+5bX/Y/i0983iCr4+ctLRpx
        NghsfrkTcRCo98TUsuQ+DNpVSA==
X-Google-Smtp-Source: ABdhPJwILXvN/gcpaBDfJHt6cEhQT7gl/roFCqi9AyYjVW7g0sdtZbLU7yC+5fBIf2BrmzyKYaYQjg==
X-Received: by 2002:a05:6638:2493:: with SMTP id x19mr4391343jat.53.1598045196675;
        Fri, 21 Aug 2020 14:26:36 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 202sm1949505ila.59.2020.08.21.14.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 14:26:36 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
From:   Jens Axboe <axboe@kernel.dk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
Message-ID: <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
Date:   Fri, 21 Aug 2020 15:26:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/18/20 12:12 PM, Jens Axboe wrote:
> On 8/18/20 11:11 AM, Theodore Y. Ts'o wrote:
>> On Mon, Aug 03, 2020 at 05:02:11PM -0600, Jens Axboe wrote:
>>> ext4 uses generic_file_read_iter(), which already supports this.
>>>
>>> Cc: Theodore Ts'o <tytso@mit.edu>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> Resending this one, as I've been carrying it privately since May. The
>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>> please consider this one for 5.9. Thanks!
>>
>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>> missing something?  It's on my queue to send to Linus once I get my
>> (late) ext4 primary pull request for 5.9.
> 
> Right, it went in at the start of the merge window for 5.9. Thanks Ted!

Didn't see it in the queue that just sent in, is it still queued up?

-- 
Jens Axboe

