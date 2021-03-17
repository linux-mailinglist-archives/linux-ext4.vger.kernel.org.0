Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6D33FA35
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Mar 2021 21:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhCQU6n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Mar 2021 16:58:43 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:33881 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhCQU6U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Mar 2021 16:58:20 -0400
Received: from [192.168.111.103] (p4fd975c2.dip0.t-ipconnect.de [79.217.117.194])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 12HKwC80011602
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Wed, 17 Mar 2021 21:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1616014692;
        bh=3HNa2+WqZpFC4qf3gJ4PGfw6tm9BCKyr+RH5gsmRmqU=;
        h=Subject:Cc:References:From:Date:In-Reply-To;
        b=hwjka0Vg//0SHZ9HoOpgkDI5EMpeLvV0tl4RglTFV++67mSkzT8eVwghi8zVQSYo+
         QShNcEpONvsBOb6tZ7tKuCYu/77QtsBfWLR9ziaJD/pSUVdrcpwc5cRSdUDYxxNtb0
         KBq/kuHAnXvm3dD5RnNxJZaAfzwJrphyu+YGKwjU=
Subject: Re: [PATCH v3] Updated locking documentation for transaction_t
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210211171410.17984-1-alexander.lochmann@tu-dortmund.de>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Message-ID: <c309db05-bca5-7bcd-cf86-a85637d49407@tu-dortmund.de>
Date:   Wed, 17 Mar 2021 21:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211171410.17984-1-alexander.lochmann@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Does this patch look good to you either?

- Alex

On 11.02.21 18:14, Alexander Lochmann wrote:
> Some members of transaction_t are allowed to be read without
> any lock being held if accessed from the correct context.
> We used LockDoc's findings to determine those members.
> Each member of them is marked with a short comment:
> "no lock needed for jbd2 thread".
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/jbd2.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..1f19d19f6435 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -594,18 +594,18 @@ struct transaction_s
>  	 */
>  	unsigned long		t_log_start;
>  
> -	/* Number of buffers on the t_buffers list [j_list_lock] */
> +	/* Number of buffers on the t_buffers list [j_list_lock, no locks needed for jbd2 thread] */
>  	int			t_nr_buffers;
>  
>  	/*
>  	 * Doubly-linked circular list of all buffers reserved but not yet
> -	 * modified by this transaction [j_list_lock]
> +	 * modified by this transaction [j_list_lock, no locks needed for jbd2 thread]
>  	 */
>  	struct journal_head	*t_reserved_list;
>  
>  	/*
>  	 * Doubly-linked circular list of all metadata buffers owned by this
> -	 * transaction [j_list_lock]
> +	 * transaction [j_list_lock, no locks needed for jbd2 thread]
>  	 */
>  	struct journal_head	*t_buffers;
>  
> @@ -631,7 +631,7 @@ struct transaction_s
>  	/*
>  	 * Doubly-linked circular list of metadata buffers being shadowed by log
>  	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
> -	 * list match each other one for one at all times. [j_list_lock]
> +	 * list match each other one for one at all times. [j_list_lock, no locks needed for jbd2 thread]
>  	 */
>  	struct journal_head	*t_shadow_list;
>  
> 

-- 
Technische Universität Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al
