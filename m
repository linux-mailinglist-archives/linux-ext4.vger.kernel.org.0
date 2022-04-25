Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F950DFA1
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Apr 2022 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiDYMGk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Apr 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiDYMGj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Apr 2022 08:06:39 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2D28E01;
        Mon, 25 Apr 2022 05:03:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=cuibixuan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VBD1ABs_1650888198;
Received: from 30.225.28.143(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0VBD1ABs_1650888198)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:03:19 +0800
Message-ID: <8a37e573-327a-e262-51fe-769db7110a15@linux.alibaba.com>
Date:   Mon, 25 Apr 2022 20:03:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSCAtbmV4dF0gamJkMjogdXNlIHRoZSBj?=
 =?UTF-8?Q?orrect_print_format?=
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, mingo <mingo@redhat.com>,
        "yi.zhang" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>
References: <1647619000-17758-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20220321092503.liyi6eqrar52cc5n@quack3.lan>
 <df9b8f54-274d-404c-a698-c88a18849810.cuibixuan@linux.alibaba.com>
 <20220422091455.rzr265lcht46gub3@quack3.lan>
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
In-Reply-To: <20220422091455.rzr265lcht46gub3@quack3.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks. :-)


Bixuan Cui

在 2022/4/22 下午5:14, Jan Kara 写道:
> Hello,
>
> thanks for noticing. It is probably because this patch was not CCed neither
> to ext4 development mailing list, nor to the ext4 maintainer. Added now.
> Ted, can you please pick up this patch? Lore has it so b4, can pick it up
> just fine. Thanks!
