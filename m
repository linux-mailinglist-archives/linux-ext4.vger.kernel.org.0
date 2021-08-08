Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4CF3E3D04
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 00:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhHHWT5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 18:19:57 -0400
Received: from mail.valdk.tel ([185.177.150.13]:56928 "EHLO mail.valdk.tel"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhHHWT5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 8 Aug 2021 18:19:57 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Aug 2021 18:19:56 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17C1324C9D6
        for <linux-ext4@vger.kernel.org>; Mon,  9 Aug 2021 01:13:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
        s=msrv; t=1628460786; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=IKE+K7Fxy/2eZytNdt8Wao25k1SAAv/sWNa9wAiClHY=;
        b=SQMwssEZ7v3SfukDHLI1na61JhS5ZIMqM+g1mvOqIILySbi6hX/5Sq5PVB9sl+OZ22RvDY
        pGwQRtFI3O5zYGMqzMR08D78VagAtkf0QUkF6ODGdxkNN5Xbbwkj0C08pogShtJy3mQ9Jv
        dUTQmgM+fKuEWRTi47vLA98B+ICi8PoIu9+98GPyZgrKCnIPDXrgplQZKRefYES6Sz8zQG
        kDTSB5XhhxAhwugjszY2RqPB7TQtGemNibEGRJYzUt9HENGWvL6LzyXCQTOy97IpjEFYJw
        Yw1DRsD3oGSGcusejhb4Ch8Pks3xc5+ndK/ZEDGpCC/RorNGNZRRFDVxVWgzyQ==
To:     linux-ext4@vger.kernel.org
From:   ValdikSS <iam@valdikss.org.ru>
Subject: ext4lazyinit reads HDD data on mount since 5.13
Message-ID: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
Date:   Mon, 9 Aug 2021 01:13:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.5.0) Gecko/20100101,
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
