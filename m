Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCAD28202D
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJCBip (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 21:38:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51287 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725550AbgJCBip (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Oct 2020 21:38:45 -0400
X-IronPort-AV: E=Sophos;i="5.77,329,1596470400"; 
   d="scan'208";a="99854525"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Oct 2020 09:38:42 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 36EC848990DF;
        Sat,  3 Oct 2020 09:38:40 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sat, 3 Oct 2020 09:38:37 +0800
Message-ID: <5F77D61D.7030701@cn.fujitsu.com>
Date:   Sat, 3 Oct 2020 09:38:37 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        <ebiggers@kernel.org>, <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com> <20201001205643.GA656789@mit.edu>
In-Reply-To: <20201001205643.GA656789@mit.edu>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 36EC848990DF.AA801
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/10/2 4:56, Theodore Y. Ts'o wrote:
> On Tue, Jul 28, 2020 at 01:33:21PM +0800, Xiao Yang wrote:
>> Use the letter 'x' to set/get dax attribute on a directory/file.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> Reviewed-by: Andreas Dilger<adilger@dilger.ca>
> Thanks, applied.  Apologies for the delay.
Hi Ted,

Thank you for applying this patch. :-)

Could you apply another fix for fsdax on ext4?
https://www.spinics.net/lists/linux-ext4/msg73863.html

Best Regards,
Xiao Yang
> 		  	    	- Ted
>
>
> .
>



