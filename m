Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57107443E9
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389651AbfFMQdX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:33:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730818AbfFMIDy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Jun 2019 04:03:54 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6065A83989627B163AFF;
        Thu, 13 Jun 2019 16:03:51 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 16:03:48 +0800
Subject: =?UTF-8?Q?Re:_=e5=9b=9e=e5=a4=8d:_[PATCH_2/2]_f2fs:_only_set_projec?=
 =?UTF-8?Q?t_inherit_bit_for_directory?=
To:     Wang Shilong <wshilong@ddn.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Andreas Dilger <adilger@dilger.ca>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
 <73fb9e88-d3f5-9420-d6d8-82ff4354e4d6@huawei.com>
 <MN2PR19MB3167496236BA4D366EAF5D36D4EF0@MN2PR19MB3167.namprd19.prod.outlook.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <110862e6-fd2a-b580-fec8-18a9b351ecb1@huawei.com>
Date:   Thu, 13 Jun 2019 16:03:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <MN2PR19MB3167496236BA4D366EAF5D36D4EF0@MN2PR19MB3167.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/6/13 15:34, Wang Shilong wrote:
> Hi Chao,
> 
>  I just sent a V2, but I think we'd better do that when reading inode, for two reasons:
> 
> 1) not only F2FS_IOC_GETFLAGS need filter flags but also F2FS_IOC_FSGETXATTR need that, so the amended parts is not enough IMO.
> 
> 2) doing that by reading inode give a benefit that we could correct on disk flags for regular file next dirtying inode happen.

Hi Shilong, agreed, I'm okay with that change. :)

Thanks,
