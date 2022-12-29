Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC08E6588AA
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Dec 2022 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiL2CfB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Dec 2022 21:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2Ce7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Dec 2022 21:34:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFD13DCB
        for <linux-ext4@vger.kernel.org>; Wed, 28 Dec 2022 18:34:58 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NjCB54dm8zRqLX;
        Thu, 29 Dec 2022 10:33:33 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 10:34:55 +0800
Message-ID: <700dbfc0-9bae-db7f-a96f-f00cd1c2be43@huawei.com>
Date:   Thu, 29 Dec 2022 10:34:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/1] ext4: Don't show commit interval if it is zero
Content-Language: en-US
From:   "wangjianjian (C)" <wangjianjian3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
References: <20221219015140.877136-1-wangjianjian3@huawei.com>
In-Reply-To: <20221219015140.877136-1-wangjianjian3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.234.194]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Any comment about this ? I think this is a regression.
