Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4E65DDC8
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbjADUm3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 15:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbjADUm2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 15:42:28 -0500
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AE71CFC1
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 12:42:26 -0800 (PST)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob02.websitewelcome.com (Postfix) with ESMTP id 3045EEEA7
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 20:42:26 +0000 (UTC)
Received: from rs019.webhostbox.net ([162.241.123.62])
        by cmsmtp with ESMTP
        id DAafps9qxHV9cDAafpC8Hi; Wed, 04 Jan 2023 20:42:26 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mandals.net
        ; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:To:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GW+8UEuWok8vSf1E5+PZGT+Rjubkd7X1jyvMT9mi8IE=; b=wUzv7PARH3pS7DhkGMyhUMpgIA
        Ok2Xacrb0Zfjpk84q/FMKnYKcJLrIaTqY7Sn0IP3ul/A6EYmfKpz/VPqSGUHXZJj+p6Vd7AeVVmx9
        znKiEMjvroMUSQ7TmoWV5bCJm/M23tQzYD6/dhbEe4mftKKkaIK3nd6IT1/YLBWL4BvGpz8DmAXr+
        k3X5si2kaL6ksj7WkXfo/8CJzAPIdzXyJ8xTGHO/vaRJ6NtG7t17F2sqpP4daWl/Apgv7sE8rPniN
        Y/9n7FkoZN2S71AJ04rxP6l3NDic8WWar6HKm4yVEEUfAV01PcpY8xhX9PXi2bbnVvpLIVVkusXCf
        M5ySHYVw==;
Received: from [103.211.13.83] (port=51354 helo=[192.168.1.105])
        by rs019.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <atanu@mandals.net>)
        id 1pDAaf-001gab-2V
        for linux-ext4@vger.kernel.org;
        Wed, 04 Jan 2023 20:42:25 +0000
Message-ID: <69d38609-9e48-cd84-8b70-cc895e2551d3@mandals.net>
Date:   Thu, 5 Jan 2023 02:12:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
From:   Atanu M <atanu@mandals.net>
To:     linux-ext4@vger.kernel.org
Subject: Pls. keep noacl & nouser_xattr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rs019.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mandals.net
X-BWhitelist: no
X-Source-IP: 103.211.13.83
X-Source-L: No
X-Exim-ID: 1pDAaf-001gab-2V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.105]) [103.211.13.83]:51354
X-Source-Auth: atanu@mandals.net
X-Email-Count: 1
X-Source-Cap: bWFuZGFsczthY2xhYm5odTtyczAxOS53ZWJob3N0Ym94Lm5ldA==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIEh5PTINnmvmm3NgBU+7eB2sWN4aEM+fghrleSQFOuycoY4VVjZRyC3QEGVU8jOH9lxG+it0M07iRHgb3EIaNT/QlGJJP+pmeqsjom6/HTTRngCHr6i
 GgS85cdygKljK3XrLxu/sdirzJWl7LmO3FTeTLFtsZQzD/gWQkt9zEacJBPI6v5rC8qjlBfWunlsg1VfqyB+jkXjJOLm99q/Ll4=
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear friends,

Pls. keep noacl  & nouser_xattr  mount options

rgds

Atanu

