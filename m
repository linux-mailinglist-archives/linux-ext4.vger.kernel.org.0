Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C23647D58
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 06:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLIFiz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 00:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLIFiz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 00:38:55 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADF76148
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 21:38:54 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B95cTEA023119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 00:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670564312; bh=QUqO5sSTLnpuFMxRHk1r5k6n02DwG6erNhvt6C50DaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QT7KSUSs77zBjfhrVuR5nOghMqPsyIFDaJbuD8ld+xlLHtALwvfZ8DFMz+LVM+M12
         xDsXiNp6dpTzIZSD4DXDqhYcoZuUmuqHPFKIUdKYjGLjdPSb7AWTtIblg3zv01smX2
         YrMQr4eaWUMDsyqBsGcNW10U14oY/836LW6LLXGuOSCt7hgXVzDx5Y3OAY4EYD5nWW
         I7G1chVgJ3WoXsk0dQWUsOWTq0BpM17DpUs1gEGzU3LXuOxtkZlA7u7Tlq4wz7LNGx
         4u+BvM5+JysSEMBbrpcWheQTh3QPgRpsxZmhhm4sEDMtCG4VuLWFPQcRnfHVfdNefl
         lj9vLK4XvkqPg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CC56615C3AE9; Fri,  9 Dec 2022 00:38:29 -0500 (EST)
Date:   Fri, 9 Dec 2022 00:38:29 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 3/4] ext4: rename xattr_find_entry() and
 __xattr_check_inode()
Message-ID: <Y5LJ1QU1JND2fuVK@mit.edu>
References: <20221208023233.1231330-1-yebin@huaweicloud.com>
 <20221208023233.1231330-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208023233.1231330-4-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 10:32:32AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Prepend ext4 prefix to function names of xattr_find_entry() and
> __xattr_check_inode() for consistency with other functions in ext4
> xattr module.

The reason why these function names don't have the ext4 prefix is
because functions are static, so there is need to worry about
namespace pollution.

For static functions, there is no real need to add the ext4 prefix, so
why not keep the functions shorter?  Yes, there are places where
static functions have the ext4 prefix.  The main reason why we have
changed it is that it's not worth the code churn.  Similarly, adding
the ext4 prefix is *definitely* not worth the code churn.

Cheers,

					- Ted
