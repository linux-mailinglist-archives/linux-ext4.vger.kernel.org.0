Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE13C1C762
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENLBa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 07:01:30 -0400
Received: from ns.gsystem.sk ([62.176.172.50]:37766 "EHLO gsystem.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfENLB3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 May 2019 07:01:29 -0400
X-Greylist: delayed 1116 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 07:01:28 EDT
Received: from [192.168.1.3]
        by gsystem.sk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <linux@zary.sk>)
        id 1hQUtP-0003kB-DR; Tue, 14 May 2019 12:42:43 +0200
From:   Ondrej Zary <linux@zary.sk>
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
Date:   Tue, 14 May 2019 12:42:39 +0200
User-Agent: KMail/1.9.10
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net> <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
In-Reply-To: <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201905141242.39800.linux@zary.sk>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tuesday 14 May 2019, Arthur Marsh wrote:
> Apologies, I had forgotten to
> 
> got bisect - - hard origin/master
> 
> I am still seeing the corruption leading to the invalid block error on 5.1.0+ kernels on both my machines.
> 
> Arthur. 

I've been probably hit by the same bug. ext3 filesystem on my test machine was corrupted twice with 5.1.0+. Only the corruption was heavier. Some files that were open (e.g. logs) became cros-linked with files that were not used for ages.

-- 
Ondrej Zary
