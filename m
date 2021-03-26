Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0ED34A31E
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Mar 2021 09:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCZITZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Mar 2021 04:19:25 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:37351 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZIS7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Mar 2021 04:18:59 -0400
Received: from [192.168.111.103] (p4fd97b97.dip0.t-ipconnect.de [79.217.123.151])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 12Q8IknN008587
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 09:18:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1616746726;
        bh=ben2mc9PqCco6wmBW93BX/pWuiCf7vcnCghf41yvMuE=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=cVOdF1SxmarPMH195YKtL8CsuGpvsEG+imVHH9HlrEDGP6YRyfebyZYUvGVNIPgfE
         6TEEbrE4wv27+TXz4qChBpB6gFsjOfjN4TDMGUpfTKNw3zy72ngHYfgCHkNCEkgFZI
         24TkH3eE0P7pxvnCJUnGwPdm9GMOfuhKEgFKkggg=
To:     Jan Kara <jack@suse.cz>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
 <20210211093027.GI19070@quack2.suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: Re: [PATCH 1/2] Updated locking documentation for transaction_t
Message-ID: <ec682a4c-f4f7-35fe-dc35-6c0b53d6ecda@tu-dortmund.de>
Date:   Fri, 26 Mar 2021 09:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211093027.GI19070@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11.02.21 10:30, Jan Kara wrote:
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 99d3cd051ac3..18f77d9b1745 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -594,18 +594,18 @@ struct transaction_s
>>  	 */
>>  	unsigned long		t_log_start;
>>  
>> -	/* Number of buffers on the t_buffers list [j_list_lock] */
>> +	/* Number of buffers on the t_buffers list [j_list_lock, no lock for quick racy checks] */
>>  	int			t_nr_buffers;
> 
> So this case is actually somewhat different now that I audited the uses.
> There are two types of users - commit code (fs/jbd2/commit.c) and others.
> Other users properly use j_list_lock to access t_nr_buffers. Commit code
> does not use any locks because committing transaction is fully in
> ownership of the jbd2 thread and all other users need to check & wait for
> commit to be finished before doing anything with the transaction's buffers.

I'm still trying understand how thinks work:
Accesses to transaction_t might occur from different contexts. Thus,
locks are necessary. If it comes to the commit phase, every other
context has to wait until jbd2 thread has done its work. Therefore, jbd2
thread does not need any locks to access a transaction_t (or just parts
of it?) during commit phase.
Is that correct?

If so: I was thinking whether it make sense to ignore all memory
accesses to a transaction_t (or parts of it) that happen in the commit
phase. They deliberately ignore the locking policy, and would confuse
our approach.

Is the commit phase performed by jbd2_journal_commit_transaction()?
We would add this function to our blacklist for transaction_t.

- Alex
-- 
Technische Universität Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al
