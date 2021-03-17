Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BA33FA31
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Mar 2021 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhCQU6J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Mar 2021 16:58:09 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:60615 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhCQU5t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Mar 2021 16:57:49 -0400
Received: from [192.168.111.103] (p4fd975c2.dip0.t-ipconnect.de [79.217.117.194])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 12HKvbBE011213
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Wed, 17 Mar 2021 21:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1616014658;
        bh=K+a8c+n3uYKrcQ4YEDKq+ACmy6NKdSX55u22gqzFhPI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=ePom3An5c9eK8eBQpMBfg+tFpPiofj1xUOasOYIBstTTS1yIP+E9dIPXWeoKgtxhq
         QoG5/5Eb+gBEf0TN3rsYj72bnqEJrQwE5RzT1ZFMmt1EyxNsrh98YEsYaPxHfXiyAU
         gFYgA/1aDkBIfBzLxCl+wwdFdum3+eL4nyHiDgJw=
Subject: Re: [PATCH v2] Updated locking documentation for journal_t
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210211093754.GJ19070@quack2.suse.cz>
 <ad82c7a9-a624-4ed5-5ada-a6410c44c0b3@tu-dortmund.de>
Message-ID: <31c3e70b-c513-a9ac-8d94-211d80221942@tu-dortmund.de>
Date:   Wed, 17 Mar 2021 21:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ad82c7a9-a624-4ed5-5ada-a6410c44c0b3@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Does this patch look good to you?
Might it be ready to be merged?

- Alex

On 11.02.21 10:51, Alexander Lochmann wrote:
> Some members of transaction_t are allowed to be read without
> any lock being held if consistency doesn't matter.
> Based on LockDoc's findings, we extended the locking
> documentation of those members.
> Each one of them is marked with a short comment:
> "no lock for quick racy checks".
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/jbd2.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 18f77d9b1745..4dca33a063dd 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -768,7 +768,7 @@ enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
>  struct journal_s
>  {
>      /**
> -     * @j_flags: General journaling state flags [j_state_lock]
> +     * @j_flags: General journaling state flags [j_state_lock, no lock
> for quick racy checks]
>       */
>      unsigned long        j_flags;
> 
> @@ -808,7 +808,7 @@ struct journal_s
>      /**
>       * @j_barrier_count:
>       *
> -     * Number of processes waiting to create a barrier lock [j_state_lock]
> +     * Number of processes waiting to create a barrier lock
> [j_state_lock, no lock for quick racy checks]
>       */
>      int            j_barrier_count;
> 
> @@ -821,7 +821,7 @@ struct journal_s
>       * @j_running_transaction:
>       *
>       * Transactions: The current running transaction...
> -     * [j_state_lock] [caller holding open handle]
> +     * [j_state_lock, no lock for quick racy checks] [caller holding
> open handle]
>       */
>      transaction_t        *j_running_transaction;
> 
> @@ -1033,7 +1033,7 @@ struct journal_s
>       * @j_commit_sequence:
>       *
>       * Sequence number of the most recently committed transaction
> -     * [j_state_lock].
> +     * [j_state_lock, no lock for quick racy checks].
>       */
>      tid_t            j_commit_sequence;
> 
> @@ -1041,7 +1041,7 @@ struct journal_s
>       * @j_commit_request:
>       *
>       * Sequence number of the most recent transaction wanting commit
> -     * [j_state_lock]
> +     * [j_state_lock, no lock for quick racy checks]
>       */
>      tid_t            j_commit_request;
> 

-- 
Technische Universität Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al
