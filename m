Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE81690DBB
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjBIP5f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 10:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjBIP5e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 10:57:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2D8B752
        for <linux-ext4@vger.kernel.org>; Thu,  9 Feb 2023 07:57:33 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 319FuqRm019617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 10:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675958213; bh=XWDuEgqowYvNONg7D5VE7dPa7kK2LIp8g7pYSGZSoIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CSQAIAqbr6hJqpIKn2Z33UbkFw8Sg72CkkRXyNsfBMQh6hZi/1zgMFNUf5kbk/wsm
         IiQIV+GzDCJJgjRJgGs+R/oLB0Szpp2717VO/b8qPo43LHmX4BvxGK44WJQWGTj95k
         3ou6NjnYvoi24PyJKNeVJkCAnG2+eaf8gfuw2+9Cy8nnj9+g31ng+zAS9CJwynCzK6
         PXObd6z2a40n2e9CLVkqOq8SyfVgJnDK0n9odTan4e6xOezQ2XCbebbTr279oguRS7
         pMANr/yZmeFzzI85IM91+Lb+GSSUgnPz3GpQj7FRIy9VFSjrHk5q+CRK12MqTNZdPN
         wFehwjqlkkgtA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 02A7315C3589; Thu,  9 Feb 2023 10:56:52 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Wang Jianjian <wangjianjian3@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, zhengbowen7@huawei.com,
        wangqiang62@huawei.com, zhangzhikang1@huawei.com
Subject: Re: [PATCH 1/1] ext4: Don't show commit interval if it is zero
Date:   Thu,  9 Feb 2023 10:56:50 -0500
Message-Id: <167595818786.2451331.4287438712674756802.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221219015128.876717-1-wangjianjian3@huawei.com>
References: <20221219015128.876717-1-wangjianjian3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 19 Dec 2022 09:51:28 +0800, Wang Jianjian wrote:
> If commit interval is 0, it means using default value.
> 
> 

Applied, thanks!

[1/1] ext4: Don't show commit interval if it is zero
      commit: 934b0de1e9fdea93c4c7f2e18915c54fae67bdc6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
