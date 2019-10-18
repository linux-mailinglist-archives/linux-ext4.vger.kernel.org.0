Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D7DBC48
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2019 07:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441965AbfJRFAV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Oct 2019 01:00:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35957 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJRFAV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Oct 2019 01:00:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so2663658pgk.3
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2019 22:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Le1dfLgcN2fCoctkTgaPwRHnB7+gEY7elpUpKk1Qxm4=;
        b=qC84lI1R8NJLi3mNjyTq7m3HEqFaleMF0nhsRNKYHfAUFomRwPR5Ab4TCSuOLAMJmv
         C3gWEbSpiyoD1uURzOXYhddLA0u+30eR/c0HO4bV+jrAik5OPbKe7CCpX1d3A7C98/8f
         HDis0dDs7F+UBsdzUbg+BFd96BBbOrsuW73WC2RjdhO0W5tPZkCdSbppO5cOvCCostfM
         HPZxu6INOzYNDnmNTBtHv6uFBM5IBFV/vVx48EBYT0KdtHbvINGBn7zZ86Pn6GrVx9tZ
         pic/9IeFVLHVW43Zw0xl8eTvaaPbfKPGimr3jYRZ6lTdi/0k2ceH2P/J9GfCtNlkmMZL
         eBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Le1dfLgcN2fCoctkTgaPwRHnB7+gEY7elpUpKk1Qxm4=;
        b=QI+nQ4p40gOXFkVBrw0AxfAJMSm/lxLOzZnqrjPh3u4CgUfrS3smRCdX+eN78rFuG0
         h6mBcovLkjLYr6w25Vqlfp1juInLZrPDrg/kjANrKM1Tt3Xzmkzp29VTAounPhh7YBjB
         t8hzaQvFL6/MrpyszVWMTiOKQUPp5P/mNqIoEz42d1P8CP7YoDL472HtP660AlzfO7ai
         y6xtHhu35hbJAM+TwD80ILmRzfNy7+HQ194AecrjcbCfXN8kFOV9s7LQm5xj1WA3OtAI
         czfze36R/bQiwg0zRenhstLZ1EmC0TqWi2vrSxaPk1JcFiwZn/cEZb5wcTD/zl9H0KJO
         zn+w==
X-Gm-Message-State: APjAAAWEKT1MW9bPTXJPIOyzq8lzSpT/X21FESYsEVq1mXsHQ/tq1BEZ
        GmW0Qu74Bdr9Makp/pUXX1esFiydWRDYGQ==
X-Google-Smtp-Source: APXvYqwNxeKmI0ojwcSsj8jkPRqwT7AzBHlDv4+kaht5Ou4NkRX8r37tXu/0ZI6bdE5JobLbemeTmg==
X-Received: by 2002:a65:62d2:: with SMTP id m18mr7894087pgv.117.1571374319689;
        Thu, 17 Oct 2019 21:51:59 -0700 (PDT)
Received: from [10.34.123.118] ([103.5.140.168])
        by smtp.gmail.com with ESMTPSA id 127sm6555897pfw.6.2019.10.17.21.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:51:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 12/13] docs: Add fast commit documentation
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20191018015655.GB21137@mit.edu>
Date:   Fri, 18 Oct 2019 13:51:56 +0900
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C41A9852-DFA0-4F1A-A984-29A71D23CEFB@dilger.ca>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com> <20191001074101.256523-13-harshadshirwadkar@gmail.com> <20191018015655.GB21137@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

What about rename or hard link?

Cheers, Andreas

> On Oct 18, 2019, at 10:56, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
>> On Tue, Oct 01, 2019 at 12:41:01AM -0700, Harshad Shirwadkar wrote:
>> +
>> +Multiple fast commit blocks are a part of one sub-transaction. To
>> +indicate the last block in a fast commit transaction, fc_flags field
>> +in the last block in every subtransaction is marked with "LAST" (0x1)
>> +flag. A subtransaction is valid only if all the following conditions
>> +are met:
>> +
>> +1) SUBTID of all blocks is either equal to or greater than SUBTID of
>> +   the previous fast commit block.
>> +2) For every sub-transaction, last block is marked with LAST flag.
>> +3) There are no invalid blocks in between.
> 
> I'm wondering why we need to support multiple inodes being modified in
> a single transaction.  As we currently have defined what can be done,
> all updates to an inode should be free standing and not dependent on a
> change to another inode, right?  And today, one block only modifies
> one inode.
> 
> The only reason why we might want to define a sub-transaction as being
> composed of multiple inodes, which must all be updated in an
> all-or-nothing fashion, is the swap boot inode ioctl, and if that's
> the only one, I wonder if it's worth the extra complexity.
> 
> Am I missing anything?
> 
>                    - Ted
