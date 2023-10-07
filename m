Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7507BC395
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Oct 2023 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJGBUv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 21:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjJGBUu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 21:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58953BF
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696641603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDPgDyc+rpy+6pDy/WUApGWgXd3+hqYtxVhpZw2Z+oU=;
        b=XuJzK0pzZPRjWE3ARyaQdo0iLhcgKaecYuOk8XxD1aRFfW6OZwVWwqJVcY0jNv0AVW7uk/
        +ZuD/xGn515OFdpx74VovvvH9nST/VJYr7tkSIqh1VOCxjN0l4T1YomMOIaOX3BZAjnZRS
        LH7vq+Vq2r8xNW4LC/r4U0UA5FdbO4E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-ryffRbIePXCxPEagC6WzDQ-1; Fri, 06 Oct 2023 21:20:01 -0400
X-MC-Unique: ryffRbIePXCxPEagC6WzDQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c625d701b9so25048715ad.0
        for <linux-ext4@vger.kernel.org>; Fri, 06 Oct 2023 18:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696641600; x=1697246400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDPgDyc+rpy+6pDy/WUApGWgXd3+hqYtxVhpZw2Z+oU=;
        b=oL26E7dkl8eCQPOqoFFg3NzsSW2VJS5eUzEbTTfWNFJt668ad0x9517rL5hn/ZZ1yN
         lNVeN6DnXiwh7wCRxvtSmXonFJkHvQz/UbMHemfwNwKKWcjOEDYFFBlAXhb21/2VcUCk
         Y5CLBjPsvAGj8xG6eZaga/YqHNOjCE8lEckkfC8PRLHZW9WKvuK+7cd/2m9ytVEa3snm
         XyJkjsMHSRTU+s3whrFVMm/qSiKaAOfeNv07Ua2pBi/vxy49Wil4j+2BjwkqGMM9OTve
         MyiW+cbZ3gNz3lGGmlNSSpEMzCTmR+/II7TnGttL3LoYnjtaCvR3IJebTek6V4292jwY
         Tf2g==
X-Gm-Message-State: AOJu0Yx2bt0SERGBAUDPS75nTTSoPODwOzhCdVyVkDHhpKPk5KZz64wg
        sNDUH8LOwUiittHeOPNdNNjdzXEJaf8GGOFYSUjpbskWbnc2XeNsqos/UPqq/7upc8DsfyAtlnI
        v6PfDgq6RR94a3+WOCmOZcQ==
X-Received: by 2002:a17:903:22cb:b0:1c4:5e9e:7865 with SMTP id y11-20020a17090322cb00b001c45e9e7865mr11138683plg.0.1696641600321;
        Fri, 06 Oct 2023 18:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE27ukV5xdoxeuBFbDNnq/3SZ1mSxu4JFqOyNbj44S+UpM/DrxTnSraC3Bo0wkIV9f7/lhB9A==
X-Received: by 2002:a17:903:22cb:b0:1c4:5e9e:7865 with SMTP id y11-20020a17090322cb00b001c45e9e7865mr11138672plg.0.1696641600005;
        Fri, 06 Oct 2023 18:20:00 -0700 (PDT)
Received: from [10.72.112.33] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001bdc3768ca5sm4554814plh.254.2023.10.06.18.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 18:19:59 -0700 (PDT)
Message-ID: <880bb6a8-d641-003d-1e38-d0115d22eabc@redhat.com>
Date:   Sat, 7 Oct 2023 09:19:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: apply umask if POSIX ACL support is disabled
Content-Language: en-US
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Max Kellermann <max.kellermann@ionos.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
References: <20230919081900.1096840-1-max.kellermann@ionos.com>
 <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 10/3/23 23:32, Dave Kleikamp wrote:
> I think this is sane, but the patch needs a description of why this is 
> necessary for these specific file systems.
>
Sounds reasonable.

Thanks

- Xiubo


> Thanks,
> Shaggy
>
> On 9/19/23 3:18AM, Max Kellermann wrote:
>> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
>> ---
>>   fs/ceph/super.h           | 1 +
>>   fs/ext2/acl.h             | 1 +
>>   fs/jfs/jfs_acl.h          | 1 +
>>   include/linux/posix_acl.h | 1 +
>>   4 files changed, 4 insertions(+)
>>
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index 51c7f2b14f6f..e7e2f264acf4 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -1194,6 +1194,7 @@ static inline void 
>> ceph_forget_all_cached_acls(struct inode *inode)
>>   static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>>                        struct ceph_acl_sec_ctx *as_ctx)
>>   {
>> +    *mode &= ~current_umask();
>>       return 0;
>>   }
>>   static inline void ceph_init_inode_acls(struct inode *inode,
>> diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
>> index 4a8443a2b8ec..694af789c614 100644
>> --- a/fs/ext2/acl.h
>> +++ b/fs/ext2/acl.h
>> @@ -67,6 +67,7 @@ extern int ext2_init_acl (struct inode *, struct 
>> inode *);
>>     static inline int ext2_init_acl (struct inode *inode, struct 
>> inode *dir)
>>   {
>> +    inode->i_mode &= ~current_umask();
>>       return 0;
>>   }
>>   #endif
>> diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
>> index f892e54d0fcd..10791e97a46f 100644
>> --- a/fs/jfs/jfs_acl.h
>> +++ b/fs/jfs/jfs_acl.h
>> @@ -17,6 +17,7 @@ int jfs_init_acl(tid_t, struct inode *, struct 
>> inode *);
>>   static inline int jfs_init_acl(tid_t tid, struct inode *inode,
>>                      struct inode *dir)
>>   {
>> +    inode->i_mode &= ~current_umask();
>>       return 0;
>>   }
>>   diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
>> index 0e65b3d634d9..54bc9b1061ca 100644
>> --- a/include/linux/posix_acl.h
>> +++ b/include/linux/posix_acl.h
>> @@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
>>   static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>>           struct posix_acl **default_acl, struct posix_acl **acl)
>>   {
>> +    *mode &= ~current_umask();
>>       *default_acl = *acl = NULL;
>>       return 0;
>>   }
>

