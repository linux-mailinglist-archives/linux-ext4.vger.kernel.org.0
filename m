Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990E691F44
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjBJMrR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Feb 2023 07:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJMrR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Feb 2023 07:47:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D43CE3C;
        Fri, 10 Feb 2023 04:47:15 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PCtlv59tBzdbBT;
        Fri, 10 Feb 2023 20:46:51 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 20:47:10 +0800
Subject: Re: [PATCH v2 0/6] fix error flag covered by journal recovery
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ye Bin <yebin10@huawei.com>
References: <20230210032044.146115-1-yebin@huaweicloud.com>
 <20230210115628.l6b4zukudqcp5hot@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <4a768ba9-3b52-250c-1b86-d7b4314b4351@huawei.com>
Date:   Fri, 10 Feb 2023 20:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230210115628.l6b4zukudqcp5hot@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/2/10 19:56, Jan Kara wrote:
> Hello!
> 
> On Fri 10-02-23 11:20:38, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Diff v2 vs v1:
>> Move call 'j_replay_prepare_callback' and 'j_replay_end_callback' from
>> ext4_load_journal() to jbd2_journal_recover().
>>
>> When do fault injection test, got issue as follows:
>> EXT4-fs (dm-5): warning: mounting fs with errors, running e2fsck is recommended
>> EXT4-fs (dm-5): Errors on filesystem, clearing orphan list.
>> EXT4-fs (dm-5): recovery complete
>> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro
>>
>> EXT4-fs (dm-5): recovery complete
>> EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro
>>
>> Without do file system check, file system is clean when do second mount.
>> Theoretically, the kernel will not clear fs error flag. In errors=remount-ro
>> mode the last super block is commit directly. So super block in journal is
>> not uptodate. When do jounral recovery, the uptodate super block will be
>> covered by jounral data. If super block submit all failed after recover
>> journal, then file system error flag is lost. When do "fsck -a" couldn't
>> repair file system deeply.
>> To solve above issue we need to do extra handle when do super block journal
>> recovery.
> 
> Thanks for the patches. Looking through the patches, I think this is a bit
> of an overengineering for the problem at hand. The only thing that is
> really worth preserving so that it is not lost after journal replay is the
> error information. So in ext4_load_journal() I would just save that if
> EXT4_ERROR_FS is set in es->s_state before journal replay and restore it
> after journal replay. Sure if the superblock write during journal replay
> succeeds but the write restoring the error information fails, we will loose
> the error information but that is so unlikely in practice that I don't
> think it is really worth complicating the code for it. Also the only
> downside is we will loose the information there is some error in the
> filesystem - we'll soon find that out again anyway :).
> 

I think so, also add a error message if we failed to restoring the error
information, it could let us know what happened.

Thanks,
Yi.
