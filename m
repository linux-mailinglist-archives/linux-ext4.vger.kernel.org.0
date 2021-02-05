Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F863110D9
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Feb 2021 20:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhBERbh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Feb 2021 12:31:37 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:49571 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhBEP7l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Feb 2021 10:59:41 -0500
Received: from [192.168.1.65] (i5C741D6D.versanet.de [92.116.29.109])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 115FVs0G003678
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 5 Feb 2021 16:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1612539115;
        bh=GDJDmVMjKEP70ECpg5Q5xJQJGwu66sZLjQ4SUrOyUDE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=VguVyhlHu7EflDBR5ouLZIa+jy4zu3i996zIvIjt3BFdznagP5r287YF+uenM/2PW
         86PKlghNuJ0LwGaFODTEP5DIYtWaPpPlS5d8oeA+sPwYpkuLOIAiOny/NYgOt2qJUI
         jZkUOm+OYDGk7DmaQfcBrLM6ZErNxT6XEyklJTm8=
Subject: Re: [RFC] Fine-grained locking documentation for jbd2 data structures
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To:     tytso@mit.edu, Jan Kara <jack@suse.com>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-ext4@vger.kernel.org
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
Message-ID: <14dbc946-b0c5-4165-3e6a-3cbe3c6a74b4@tu-dortmund.de>
Date:   Fri, 5 Feb 2021 16:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted, hi Jack,

have you had the chance to review our results?

Cheers,
Alex

On 15.10.20 15:56, Alexander Lochmann wrote:
> Hi folks,
> 
> when comparing our generated locking documentation with the current
> documentation
> located in include/linux/jbd2.h, I found some inconsistencies. (Our
> approach: https://dl.acm.org/doi/10.1145/3302424.3303948)
> According to the official documentation, the following members should be
> read using a lock:
> journal_t
> - j_flags: j_state_lock
> - j_barrier_count: j_state_lock
> - j_running_transaction: j_state_lock
> - j_commit_sequence: j_state_lock
> - j_commit_request: j_state_lock
> transactiont_t
> - t_nr_buffers: j_list_lock
> - t_buffers: j_list_lock
> - t_reserved_list: j_list_lock
> - t_shadow_list: j_list_lock
> jbd2_inode
> - i_transaction: j_list_lock
> - i_next_transaction: j_list_lock
> - i_flags: j_list_lock
> - i_dirty_start: j_list_lock
> - i_dirty_start: j_list_lock
> 
> However, our results say that no locks are needed at all for *reading*
> those members.
> From what I know, it is common wisdom that word-sized data types can be
> read without any lock in the Linux kernel.
> All of the above members have word size, i.e., int, long, or ptr.
> Is it therefore safe to split the locking documentation as follows?
> @j_flags: General journaling state flags [r:nolocks, w:j_state_lock]
> 
> The following members are not word-sizes. Our results also suggest that
> no locks are needed.
> Can the proposed change be applied to them as well?
> transaction_t
> - t_chp_stats: j_checkpoint_sem
> jbd2_inode:
> - i_list: j_list_lock
> 
> Cheers,
> Alex
> 

-- 
Technische Universität Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al
