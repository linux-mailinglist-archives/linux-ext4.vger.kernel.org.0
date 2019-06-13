Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1139443F0
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfFMQdm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:33:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59024 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730815AbfFMIBu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Jun 2019 04:01:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 563692C18C391158D724;
        Thu, 13 Jun 2019 16:01:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 16:01:46 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: only set project inherit bit for
 directory
To:     Wang Shilong <wangshilong1991@gmail.com>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Andreas Dilger <adilger@dilger.ca>, Wang Shilong <wshilong@ddn.com>
References: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fd3c0e10-cfed-d924-5948-eb2a4fd89c63@huawei.com>
Date:   Thu, 13 Jun 2019 16:01:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1560410993-26330-1-git-send-email-wshilong1991@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/6/13 15:29, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
