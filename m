Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACDC3E3D13
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhHHWwA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 18:52:00 -0400
Received: from mail.valdk.tel ([185.177.150.13]:59468 "EHLO mail.valdk.tel"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhHHWv7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 8 Aug 2021 18:51:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB91824CADF
        for <linux-ext4@vger.kernel.org>; Mon,  9 Aug 2021 01:51:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
        s=msrv; t=1628463098; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=IKE+K7Fxy/2eZytNdt8Wao25k1SAAv/sWNa9wAiClHY=;
        b=ygOWFE6X+1xk7NZeXF4F9snnY5HZYFJXEKkv61m0UjqLMPFZpUXkbz8Pyt7wPSXwDSvhoj
        UdOiKBuemKYlMiVVLDO2WKNs/ffsi6mMAa5MmJRWdHRz2wswUfbaT3O21zri+we2US1pKK
        V47iopMeHK00OT9i4C7KfWGocKhMH+WEcSw5XmTeG1KPxgWa8mR3e2VNnVfbMJRKHjx5Ti
        DgAuJMLHswvKWTiEAM5sJdiV3d2ks4/GdqfwAzJpM/CaAc49EGsD3HMVCxiNw5sSSO/ddM
        nONgljFnxuD7XiMXWFBZGS2Gzy2PBVhtaCzEuUtY2lJqRpFFRthKmu3vQfA0Yw==
From:   ValdikSS <iam@valdikss.org.ru>
Subject: ext4lazyinit reads HDD data on mount since 5.13
To:     linux-ext4@vger.kernel.org
Message-ID: <9afffe90-5f1e-7522-7383-57884081a01d@valdikss.org.ru>
Date:   Mon, 9 Aug 2021 01:51:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.5.0) Gecko/20100101,
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,
After updating to kernel 5.13, my ext4 partition is read for ~20 seconds 
upon mounting by ext4lazyinit. It does not write anything, only reads 
(inspected with iotop), and it does so only on mount and only for 
relatively short amount of time.

My partition is several years old and have been fully initialized long 
ago. Mounting with `init_itable=0` did not change anything: ext4lazyinit 
does not write anything to begin with.

5.12.15 does not have such behavior. Did I miss a configuration change? 
Is that a regression or a new feature?

