Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384E1186604
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 09:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgCPIBV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Mar 2020 04:01:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35029 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPIBV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Mar 2020 04:01:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7so9294471pgr.2;
        Mon, 16 Mar 2020 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kgzIsaXzzgS+ugoZTepolnzMAM1edOw9x44MV63g4bw=;
        b=t9LsGEiZByN2tSr65pYqj7k0d+8XlrFuLW5flEuZtMBeeUT7fNQzCpfISHZlgevRE4
         eElK7aT7qGdm3aD3uEPmzykK/mZaBddswF5/n1Ckf//fV9KDXiiqYsL1L+RW8Ov/ZDzI
         CV9Fs4SMF9gMjl/HOCzuaaNaNEaa2ynRvj292NoVIHX+1RTabKqz5HmYHoz0Kc3B+W5f
         k5upL7mztsj0SU71/j8+/7Mrs0JiHDni1Zu3rhPOcGqmHJTqjzqtHAIvwtrAnTJNBsCM
         PUehyoWzEuxX8noH1L33UOBl99O7h4s6hLSM7SnGk60Fb4zJ/SEpDahQbIpHqRgmMDwX
         4+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kgzIsaXzzgS+ugoZTepolnzMAM1edOw9x44MV63g4bw=;
        b=YG3gVCkUVVUVBRSsHc9rQL3diPBYnuXG1xs6rhQn86WKHrSlcz+uKjyaqjcWVKXKOV
         acOWMB+U2FFce7xanbKGHh2YP8cEtl1hH0DgcsvvaqKhrU5ij/1f+LEdS/NK9wrdEh/N
         m8igkyvbBKagCv2aFrAGdbVSHDCW6fSfJHF7NZXXHhfMrp/faCVqCt1MPzZh6dqGR3eM
         uzT9WiPPefaPBcennHiRwCiAuYBMkVMENoEAgrMFuTDwktPssyGVC9YdrqiVCtd2k+yz
         wb3DwswlzKCn3CakgPJCySj+xVCvlYM7pfxez6uoDQ1EmK332XhgBUfY/Mr58cb9Y2/D
         YjQw==
X-Gm-Message-State: ANhLgQ3z7Cs7lrWCcqQcRYYAbXnAgUfZQXypsoaTdw1UmZqLZ96gesDx
        VXC5gky+MOOiP9NwYJ4/FlJpzQDU
X-Google-Smtp-Source: ADFU+vv+8lt+/Nw4rxCfS3CzlzS05SlZW/RnNNxc5KjXJn3MqzVksm0+Q0xycwI7WGC8W0gVzBbCNw==
X-Received: by 2002:a62:507:: with SMTP id 7mr6313751pff.222.1584345680008;
        Mon, 16 Mar 2020 01:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 144sm69861324pfc.45.2020.03.16.01.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 01:01:19 -0700 (PDT)
Subject: Re: [PATCH] ext4: mark extents index blocks as dirty to avoid
 information leakage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e988a1db-3105-07a0-6399-38af80656af1@gmail.com>
 <20200312144642.GF7159@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <d9209144-4b20-61c7-aff3-942150806b9a@gmail.com>
Date:   Mon, 16 Mar 2020 16:01:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200312144642.GF7159@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your reply, but threre's some points implement inconsistently

1. + s attribute will cause a big performance problem. With only data
   blocks but no index blocks, it is difficult to recover the complete
   data. Therefore, we can also improve data security with the lowest
   cost.
2. In the SSD scenario, discard on some devices cannot guarantee that
   data is erased. but if we update the dirty pages of memory to disk.
   ssd will remap the corresponding lba, then the user will not be able
   to access the old data, it's security.
3. In the small file scenario, the file extent is stored on the inode.
   Because the inode block will not be forgotten by jbd2, the extent on
   the disk is always cleared after the small file is deleted. If security
   is only pretended, why not take effect on the small file.
4. If to facilitate data recovery, why do need to clear extents in
   memory? This operation does not seem to make sense.

I think that the page of the index block is not updated to disk after
the file is deleted, which may be a logical defect.

Theodore Y. Ts'o wrote on 2020/3/12 22:46:
> On Tue, Mar 03, 2020 at 04:51:06PM +0800, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> In the scene of deleting a file, the physical block information in the
>> extent will be cleared to 0, the buffer_head contains these extents is
>> marked as dirty, and then managed by jbd2, which will clear the
>> buffer_head's dirty flag by clear_buffer_dirty. However, when the entire
>> extent block is deleted, it is revoked from the jbd2, but  the extents
>> block is not redirtied.
>>
>> Not quite reasonable here, for the following concerns:
>>
>> 1. This has the risk of information leakage and leads to an interesting
>> phenomenon that deleting the entire file is no more secure than truncate
>> to 1 byte, because the whole extents physical block clear to zero in cache
>> will never written back as the page is not redirtied.
>>
>> 2. For large files, the number of index block is usually very small.
>> Ignoring index pages not get much more benefit in IO performance. But if
>> we remark the page as dirty, the page is then written back by the system
>> writeback mechanism asynchronously with little performance impact. As a
>> result, the risk of information leakage can be avoided. At least not wrose
>> than truncate file length to 1 byte
>>
>> Therefore, when the index block is released, we need to remark its page
>> as dirty, so that the index block on the disk will be updated and the
>> data is more security.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Trying to zero the extent block is only going to provide pretend
> security; the data blocks are still there, and anyone looking for the
> data can still find it if they look hard enough.  Also, for most
> files, it really doesn't matter.
>
> So, no, I don't think this patch is appropriate.a
>
> If you are really worried about the security for deleted files, I
> would suggest trying to implement the secure delete flag (chattr +s)
> for ext4, and actually trying to zero out the data blocks for those
> files where this kind of security is required.  (Please note that for
> SSD's, this probably won't provide as much security as you would like
> unless they implement the secure discard operation.)
>
> 							- Ted
