Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C84663699
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjAJBRr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 20:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjAJBRo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 20:17:44 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5828E0BC;
        Mon,  9 Jan 2023 17:17:42 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NrXvC4v4jz16MZd;
        Tue, 10 Jan 2023 09:16:07 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 09:17:39 +0800
Subject: Re: [PATCH -next v3] jbd2: Fix data missing when reusing bh which is
 ready to be checkpointed
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <libaokun1@huawei.com>, <zhanchengbin1@huawei.com>
References: <20230109134545.2234414-1-chengzhihao1@huawei.com>
 <20230109152923.fvx57xucg2vggzp6@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <30b40bab-770d-3f77-2b9c-88984ae129e1@huawei.com>
Date:   Tue, 10 Jan 2023 09:17:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230109152923.fvx57xucg2vggzp6@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Mon 09-01-23 21:45:45, Zhihao Cheng wrote >> Following process will make data lost and could lead to a 
filesystem>> corrupted problem:>>
[...]

> Just a suggestion for rephrasing of the comment below
> 
>> -		/*
>> -		 * In any case we need to clean the dirty flag and we must
>> -		 * do it under the buffer lock to be sure we don't race
>> -		 * with running write-out.
>> +		 * We need to clean the dirty flag and we must do it under the
>> +		 * buffer lock to be sure we don't race with running write-out.
>>   		 */
>>   		JBUFFER_TRACE(jh, "Journalling dirty buffer");
>>   		clear_buffer_dirty(bh);
>> +		/*
>> +		 * Setting jbddirty after clearing buffer dirty is necessary.
>> +		 * Function jbd2_journal_restart() could keep buffer on
>> +		 * BJ_Reserved list until the transaction committing, then the
>> +		 * buffer won't be dirtied by jbd2_journal_refile_buffer()
>> +		 * after committing, the buffer couldn't fall on disk even
>> +		 * last checkpoint finished, which may corrupt filesystem.
>> +		 */
> 
> As far as I understand you want to say:
> 		/*
> 		 * The buffer is going to be added to BJ_Reserved list now
> 		 * and nothing guarantees jbd2_journal_dirty_metadata()
> 		 * will be ever called for it. So we need to set jbddirty
> 		 * bit here to make sure the buffer is dirtied and written
> 		 * out when the journaling machinery is done with it.
> 		 */
> 
>>   		set_buffer_jbddirty(bh);
>>   	}
> 

Yes. The comment looks better than v3.
