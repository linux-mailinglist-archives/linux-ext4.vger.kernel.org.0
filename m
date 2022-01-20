Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2249473B
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jan 2022 07:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiATGRO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jan 2022 01:17:14 -0500
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:40672
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbiATGRO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Jan 2022 01:17:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMaOy1QrvCYHrYdcmr6T3Hit8biGpjFo7/YSP/+n+nf4HIcONOeascs6/s2yCeY59ruXunGQOo62TN51cINkjA13onyT7DjXBf2QwEvNVoFemzFfi2iey5KW9c/7FK7mDmTp3xQhcW9mV0NO4RVmSLHPFwO7YSm5k8zPyowiANBS3nBxrYEuoAKILhiaeR8XNsU6sDVJN1kgwOGfCBNj8REv19PSQe2vCmBXrwjbd+h9aaN9mB1ICXFuMbD6aPs7Mrag0ZmiIo/2Bu9E0wn+VExcVQpdLZQ/cIXxcFHCqGoclQpJ9E1/8B7pb9LZsFMuMw+CpsBjvk69arpwjCS8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjD53bNTg4yAwDk2RyCdZJLE7068eYVsBOLmowG2Vk8=;
 b=hoAxYb3EURQ+UhSpylA/B0LALEfeLfKldLe5QhfKG6IWKDRlKLFnl5EZxIuUE1/5dySEQ8FHeI3cZ7DFId7wYc1QBqqTh0pQLE+ODo23H3Q1tq+7inFa6ln2ExGJMs1pRkzm6JA0p4aqViGIpWUosv5j45xmAq1A4QFHeiwFgOrYtH6XrIXZpQZNlkAxdsmCK954iDhTtPceYE3IftupanNyJhRHcCkLEXesfYKy2rZToBaHJ2TTK/3HOhFHiFi+9yO6kdMFqFkFFQSABt4H+RdEf/3qHQ0vaRfoMD/8rk8TdoO63ndRmu7s1YCjpjvo//4JzcO8Cua59rVP98mYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjD53bNTg4yAwDk2RyCdZJLE7068eYVsBOLmowG2Vk8=;
 b=Tn37DGWvuEM4Q2slZxdxvg5/xii2s7gT9eCkqVXOmAbFkJiWzKUBcWMIOHq+mWBQh0CPvZfbCrbyXXfl5exhJqN9QSSGfjISZOA8XoEmcYcGfrEebFmrDMgBQuXm2yG2WGnRpscNuvngCtItMyuKArOG+sH30Lo3LfRJXctNUIszoOW8tbuZm6E72AasvR+NHZQ4SWMOURWzgGwHqI4lB7OKmmouUGWjvXsJBJ+lYfegFL6BEpwOBKrS/tbaWwla4jDJ8fON+6KpuW9JdPZxy0i6+yUNH+VLSFBkEKly1MnOJ4yqKoXBZGJq09pzaeeiU1vfEjFL9Yz3R4HbkLG1Xw==
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 06:17:11 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::d1) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 06:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 06:17:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 20 Jan
 2022 06:17:10 +0000
Received: from nvdebian.localnet (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 19 Jan 2022
 22:17:06 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>, <Felix.Kuehling@amd.com>,
        <linux-mm@kvack.org>, <rcampbell@nvidia.com>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Alex Sierra <alex.sierra@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <hch@lst.de>, <jgg@nvidia.com>, <jglisse@redhat.com>,
        <willy@infradead.org>
Subject: Re: [PATCH v3 10/10] tools: update test_hmm script to support SP config
Date:   Thu, 20 Jan 2022 17:17:04 +1100
Message-ID: <2287479.oUxI8j8a0I@nvdebian>
In-Reply-To: <20220110223201.31024-11-alex.sierra@amd.com>
References: <20220110223201.31024-1-alex.sierra@amd.com> <20220110223201.31024-11-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1af7bcbf-1fa8-492f-a1c4-08d9dbdc7e6a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4468A56FD8074946E9BF7D7CDF5A9@DM6PR12MB4468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBeQ+TmXgkR6GLxo2DJNBeW1dNTwHYFx+LABGrog6tvCydXXVM/ijF/aqUsi6CuaQhK0SRwhzOw2qG1qxzY0fMR1LbqoQYOtVHOZt4S4iS93CaBOESysJauMIefp2dyb1RtfJ5Q9v+LlFJ+jbUDYlFzRsPOWFR1BvpYlJEUYrb7lDv6KB4z5c35xf4DrXXnFjeYQPXdE65bs98w+5tmIpeP6YqMSMvWeHW6EMzdwq2HuljOjwoa7nL1oE5wY7f+1luvu1mjQN/nXSSF8jva9goxbKh0C+FwHWwJxXoyX1E9x5FniOGC/BM37n7h7jTsjhSp9WrLV8rboFvVcWEfFHKiXpBgKR7UXGqYslLlT/s/fewWcZAzIzQxiQMGrHxSyf7EO68R9ktz0xzKBwTyUPbyTAFsjWFzR+gV60y1d5tK6hodi+llJY0ge+pHFSY4zk1k++X5Q03tjGk7FTPwyd3lKNSZrPEowDvHsEsUpBQBM1irn1ZJERC6nHAoFPnfPPnpkXLQj8AWPAmYrANqnHw8ESs/c6qoXa6LwIbLwvmT+dsB5tDHbAXIQazSDnghtN+8UzuvXUen0HTpsRmjoHRZvNL+nGL87mH36btb/ma221otm/MieZUob+Zpz+k/lwCv5SWWyPG3vup6D0isC1ucCucZMM5ifEyeQ6dGx0lBQlW1t5XZDcrZBS32dFk+aUiZg6R5H7xWu/+qWyIO5djt80owIqt5t99EpiWF+tqhJzHT1sDMZ2FDVLYWFTJ3lzTXLJE4lcd8mzrexqarZLm+EaylVRhzirlnHG2tLwQEmzbVpe953NTmlz1KZOr8q
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(70586007)(81166007)(26005)(5660300002)(54906003)(316002)(508600001)(4326008)(110136005)(70206006)(356005)(9686003)(186003)(83380400001)(16526019)(336012)(8676002)(86362001)(9576002)(40460700001)(426003)(7416002)(2906002)(47076005)(36860700001)(82310400004)(8936002)(33716001)(39026012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 06:17:10.8591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af7bcbf-1fa8-492f-a1c4-08d9dbdc7e6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good,

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Tuesday, 11 January 2022 9:32:01 AM AEDT Alex Sierra wrote:
> Add two more parameters to set spm_addr_dev0 & spm_addr_dev1
> addresses. These two parameters configure the start SP
> addresses for each device in test_hmm driver.
> Consequently, this configures zone device type as coherent.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
> v2:
> Add more mknods for device coherent type. These are represented under
> /dev/hmm_mirror2 and /dev/hmm_mirror3, only in case they have created
> at probing the hmm-test driver.
> ---
>  tools/testing/selftests/vm/test_hmm.sh | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
> index 0647b525a625..539c9371e592 100755
> --- a/tools/testing/selftests/vm/test_hmm.sh
> +++ b/tools/testing/selftests/vm/test_hmm.sh
> @@ -40,11 +40,26 @@ check_test_requirements()
>  
>  load_driver()
>  {
> -	modprobe $DRIVER > /dev/null 2>&1
> +	if [ $# -eq 0 ]; then
> +		modprobe $DRIVER > /dev/null 2>&1
> +	else
> +		if [ $# -eq 2 ]; then
> +			modprobe $DRIVER spm_addr_dev0=$1 spm_addr_dev1=$2
> +				> /dev/null 2>&1
> +		else
> +			echo "Missing module parameters. Make sure pass"\
> +			"spm_addr_dev0 and spm_addr_dev1"
> +			usage
> +		fi
> +	fi
>  	if [ $? == 0 ]; then
>  		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
>  		mknod /dev/hmm_dmirror0 c $major 0
>  		mknod /dev/hmm_dmirror1 c $major 1
> +		if [ $# -eq 2 ]; then
> +			mknod /dev/hmm_dmirror2 c $major 2
> +			mknod /dev/hmm_dmirror3 c $major 3
> +		fi
>  	fi
>  }
>  
> @@ -58,7 +73,7 @@ run_smoke()
>  {
>  	echo "Running smoke test. Note, this test provides basic coverage."
>  
> -	load_driver
> +	load_driver $1 $2
>  	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
>  	unload_driver
>  }
> @@ -75,6 +90,9 @@ usage()
>  	echo "# Smoke testing"
>  	echo "./${TEST_NAME}.sh smoke"
>  	echo
> +	echo "# Smoke testing with SPM enabled"
> +	echo "./${TEST_NAME}.sh smoke <spm_addr_dev0> <spm_addr_dev1>"
> +	echo
>  	exit 0
>  }
>  
> @@ -84,7 +102,7 @@ function run_test()
>  		usage
>  	else
>  		if [ "$1" = "smoke" ]; then
> -			run_smoke
> +			run_smoke $2 $3
>  		else
>  			usage
>  		fi
> 




