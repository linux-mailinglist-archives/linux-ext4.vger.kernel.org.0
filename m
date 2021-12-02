Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA24665E2
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Dec 2021 15:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358823AbhLBO5g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Dec 2021 09:57:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56075 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358808AbhLBO5f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Dec 2021 09:57:35 -0500
Received: from callcc.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B2Erux2021109
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Dec 2021 09:53:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C122420136; Thu,  2 Dec 2021 09:53:56 -0500 (EST)
Date:   Thu, 2 Dec 2021 09:53:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH 0/6] solve memory leak and check whether NULL pointer
Message-ID: <YajeBKHX3eZFz63z@mit.edu>
References: <c96e1895-1b89-cdac-0239-a84b8a3ffc3e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96e1895-1b89-cdac-0239-a84b8a3ffc3e@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 02, 2021 at 07:26:25PM +0800, zhanchengbin wrote:
> Solve the memory leak of the abnormal branch and the new null pointer check
> 
> zhanchengbin (6):
>   alloc_string : String structure consistency
>   ss_execute_command : Check whether the pointer is not null before it
>     is referenced.
>   quota_set_sb_inum : Check whether the pointer is not null  before it
>     is referenced.
>   badblock_list memory leak
>   ldesc Non-empty judgment
>   io->name memory leak

The cover letter for the patch series arrived, but none of the patches
associated with it did.  Could you resend?

Thanks,

					- Ted
